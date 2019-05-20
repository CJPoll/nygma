defmodule Nygma.Elements.Form.TextInput do
  use Schemata

  @primary_key false

  defschema do
    field :text, :string, default: ""
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Form.TextInput do
  alias Nygma.Template

  def render(input, context) do
    %{
      "type" => "text_input",
      "text" => Template.inject(input.text, context)
    }
  end
end
