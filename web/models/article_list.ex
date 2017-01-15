defmodule NhkEasyToInstapaper.ArticleList do
  alias NhkEasyToInstapaper.Article

  @list_uri "http://www3.nhk.or.jp/news/easy/news-list.json"

  def fetch do
    sorted_articles() |> Enum.map(fn(article) ->
      %Article{
        title: Map.get(article, "title"),
        id: Map.get(article, "news_id"),
        date: Map.get(article, "date")
      }
    end)
  end

  defp articles_by_date do
    HTTPoison.get!(@list_uri).body
    |> String.replace("\xEF\xBB\xBF", "")
    |> Poison.decode!
    |> List.first
  end

  defp sorted_articles do
    articles_by_date() |> Map.keys |> Enum.map(fn(key) ->
      Map.get(articles_by_date(), key)
      |> Enum.sort_by(&(Map.get(&1, "news_priority_number")))
      |> Enum.reverse
      |> Enum.map(&(Map.put(&1, "date", key)))
    end) |> List.flatten
  end
end
