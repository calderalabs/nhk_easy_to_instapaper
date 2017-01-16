defmodule NhkEasyToInstapaper.Article do
  defstruct [:id, :title, :body, :date]

  def url(article) do
    "http://www3.nhk.or.jp/news/easy/#{article.id}/#{article.id}.html"
  end

  def body(article) do
    HTTPoison.get!(url(article)).body
    |> Floki.find("#newsarticle")
    |> remove_rt_tags_and_content
    |> remove_a_tags
    |> Floki.raw_html
    |> HtmlSanitizeEx.basic_html
  end

  defp remove_rt_tags_and_content(html) do
    step = fn(tag, attrs, children) ->
      {tag, attrs, children |> Enum.map(&(remove_rt_tags_and_content(&1))) |> Enum.reject(&(&1 == nil))}
    end

    case html do
      [{tag, attrs, children}] -> [step.(tag, attrs, children)]
      {"rt", _, _} -> nil
      {tag, attrs, children} -> step.(tag, attrs, children)
      x -> x
    end
  end

  defp remove_a_tags(html) do
    step = fn(tag, attrs, children) ->
      {tag, attrs, children |> Enum.map(&(remove_a_tags(&1)))}
    end

    case html do
      [{tag, attrs, children}] -> [step.(tag, attrs, children)]
      {"a", _, [children]} -> children
      {tag, attrs, children} -> step.(tag, attrs, children)
      x -> x
    end
  end
end
