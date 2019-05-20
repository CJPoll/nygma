defmodule Nygma.Elements.Form.Label do
  use Schemata

  @primary_key false

  defschema do
    field :text, :string, default: ""
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Form.Label do
  alias Nygma.Template

  def render(label, context) do
    %{
      "type" => "label",
      "text" => Template.inject(label.text, context)
    }
  end
end
