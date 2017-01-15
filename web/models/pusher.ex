defmodule NhkEasyToInstapaper.Pusher do
  alias NhkEasyToInstapaper.ArticleList

  def push_to_instapaper do
    {:ok, redis_client} = Exredis.start_link
    article_list = ArticleList.all
    push_article_at(article_list, -1, redis_client)
    Exredis.stop(redis_client)
  end

  defp push_article_at(article_list, index, redis_client) do
    article = article_list |> Enum.at(index)

    if Enum.member?(article_ids(redis_client), article.id) do
      push_article_at(article_list, index - 1, redis_client)
    else
      HTTPoison.get!("https://www.instapaper.com/api/add?username=#{System.get_env("INSTAPAPER_USERNAME")}&password=#{System.get_env("INSTAPAPER_PASSWORD")}&url=http://nhk-easy-to-instapaper.herokuapp.com/#{article.id}")
      Exredis.query(redis_client, ["LPUSH", "already_imported_articles", article.id])
    end
  end

  defp article_ids(redis_client) do
    case Exredis.query(redis_client, ["LRANGE", "already_imported_articles", "0", "-1"]) do
      :undefined -> []
      article_ids -> article_ids
    end
  end
end
