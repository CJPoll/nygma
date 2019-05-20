defprotocol Nygma.Renderable do
  def render(element, context)
end

defmodule Nygma.Elements do
  alias Nygma.Types

  def valid_types, do: ["heading", "image", "link", "text"]

  defdelegate render(element, context), to: Nygma.Renderable

  def build(type, params) do
    case Types.module(type) do
      nil ->
        {:error, %{type: "is invalid"}}

      module ->
        module.from_map(params)
    end
  end

  def build_heading(text, predicate \\ "") do
    build("heading", %{text: text, predicate: predicate})
  end

  def build_image(href, alt_text) do
    build("image", %{href: href, alt_text: alt_text})
  end

  def build_link(href, text) do
    build("link", %{href: href, text: text})
  end

  def build_text(text) do
    build("text", %{text: text})
  end
end

defimpl Nygma.Renderable, for: List do
  def render(list, context) do
    Enum.map(list, fn(element) ->
      Nygma.Renderable.render(element, context)
    end)
  end
end
