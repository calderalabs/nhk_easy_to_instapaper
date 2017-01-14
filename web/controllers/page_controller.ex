defmodule NhkEasyToInstapaper.PageController do
  use NhkEasyToInstapaper.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
