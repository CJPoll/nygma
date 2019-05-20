defmodule Nygma.Elements.Image do
  use Schemata

  @primary_key false

  defschema do
    field :alt_text, :string, source: :text, required: true
    field :href, :string, required: true
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Image do
  alias Nygma.Template

  def render(image, context) do
    %{
      "type" => "image",
      "href" => Template.inject(image.href, context),
      "alt_text" => Template.inject(image.alt_text, context)
    }
  end
end
