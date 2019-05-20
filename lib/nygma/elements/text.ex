defmodule Nygma.Elements.Text do
  use Schemata

  @primary_key false

  defschema do
    field :text, :string, default: ""
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Text do
  alias Nygma.Template

  def render(text, context) do
    %{
      "type" => "text",
      "text" => Template.inject(text.text, context)
    }
  end
end
