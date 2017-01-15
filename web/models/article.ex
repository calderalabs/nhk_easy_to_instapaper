defmodule NhkEasyToInstapaper.Article do
  defstruct [:id, :title, :body, :date]

  def url(article) do
    "http://www3.nhk.or.jp/news/easy/#{article.id}/#{article.id}.html"
  end

  def body(article) do
    HTTPoison.get!(url(article)).body
    |> Floki.find("#newsarticle")
    |> remove_rt_tags
    |> Floki.raw_html
    |> HtmlSanitizeEx.strip_tags
  end

  defp remove_rt_tags(html) do
    step = fn(tag, attrs, children) ->
      {tag, attrs, children |> Enum.map(&(remove_rt_tags(&1))) |> Enum.reject(&(&1 == nil))}
    end

    case html do
      [{tag, attrs, children}] -> [step.(tag, attrs, children)]
      {"rt", _, _} -> nil
      {tag, attrs, children} -> step.(tag, attrs, children)
      x -> x
    end
  end
end
