defmodule Nygma.Elements.Heading do
  use Schemata

  @primary_key false

  defschema do
    field :text, :string, required: true
    field :predicate, :string, default: ""
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Heading do
  alias Nygma.Template

  def render(heading, context) do
    %{
      "type" => "heading",
      "text" => Template.inject(heading.text, context)
    }
  end
end
