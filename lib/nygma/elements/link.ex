defmodule Nygma.Elements.Link do
  use Schemata

  @primary_key false

  defschema do
    field :text, :string, required: true
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Link do
  alias Nygma.Template

  def render(link, context) do
    %{
      "type" => "link",
      "href" => Template.inject(link.href, context),
      "text" => Template.inject(link.text, context)
    }
  end
end
