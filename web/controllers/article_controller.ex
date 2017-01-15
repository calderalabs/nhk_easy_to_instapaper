defmodule NhkEasyToInstapaper.ArticleController do
  use NhkEasyToInstapaper.Web, :controller
  alias NhkEasyToInstapaper.ArticleList

  def show(conn, %{ "id" => id }) do
    article = ArticleList.find(id)
    render conn, "show.html", article: article
  end
end
