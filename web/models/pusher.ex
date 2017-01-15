defmodule NhkEasyToInstapaper.Pusher do
  alias NhkEasyToInstapaper.ArticleList

  def push_to_instapaper do
    article = ArticleList.all |> List.last

    HTTPoison.get!("https://www.instapaper.com/api/add?username=#{System.get_env("INSTAPAPER_USERNAME")}&password=#{System.get_env("INSTAPAPER_PASSWORD")}&url=http://nhk-easy-to-instapaper.herokuapp.com/#{article.id}")
  end
end
