defmodule NhkEasyToInstapaper.Pusher do
  alias NhkEasyToInstapaper.ArticleList

  def push_to_instapaper do
    ArticleList.fetch |> List.last
  end
end
