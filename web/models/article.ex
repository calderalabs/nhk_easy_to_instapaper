defmodule NhkEasyToInstapaper.Article do
  defstruct [:id, :title, :body, :date]

  def url(article) do
    "http://www3.nhk.or.jp/news/easy/#{article.id}/#{article.id}.html"
  end

  def body(article) do
    HTTPoison.get!(url(article)).body
    |> Floki.find("#newsarticle")
    |> Floki.raw_html
    |> HtmlSanitizeEx.Scrubber.scrub(NhkEasyToInstapaper.Scrubber.OnlyParagraphs)
  end
end

defmodule NhkEasyToInstapaper.Scrubber.OnlyParagraphs do
  @moduledoc """
  Strips all tags except paragraphs
  """

  require HtmlSanitizeEx.Scrubber.Meta
  alias HtmlSanitizeEx.Scrubber.Meta

  # Removes any CDATA tags before the traverser/scrubber runs.
  Meta.remove_cdata_sections_before_scrub
  def scrub({"rt", _, _}), do: ""
  Meta.strip_comments
  Meta.allow_tag_with_these_attributes "p", []
  Meta.strip_everything_not_covered
end
