defmodule NhkEasyToInstapaper.Article do
  defstruct [:id, :title, :body, :date]

  def url(article) do
    "http://www3.nhk.or.jp/news/easy/#{article.id}/#{article.id}.html"
  end
end
