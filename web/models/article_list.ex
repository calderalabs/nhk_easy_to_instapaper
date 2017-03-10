defmodule NhkEasyToInstapaper.ArticleList do
  alias NhkEasyToInstapaper.Article

  @list_uri "http://www3.nhk.or.jp/news/easy/news-list.json"

  def find(id) do
    all() |> Enum.find(&(&1.id == id))
  end

  def most_recent_articles do
    all()
    |> Enum.sort_by(&(&1.date))
    |> Enum.reverse
    |> Enum.slice(0..4)
    |> Enum.shuffle
  end

  defp articles_by_date do
    HTTPoison.get!(@list_uri).body
    |> String.replace("\xEF\xBB\xBF", "")
    |> Poison.decode!
    |> List.first
  end

  defp all do
    articles_by_date() |> Map.keys |> Enum.map(fn(key) ->
      Map.get(articles_by_date(), key)
      |> Enum.map(&(Map.put(&1, "date", key)))
    end)
    |> List.flatten
    |> Enum.map(fn(article) ->
      %Article{
        title: Map.get(article, "title"),
        id: Map.get(article, "news_id"),
        date: Map.get(article, "date")
      }
    end)
  end
end
