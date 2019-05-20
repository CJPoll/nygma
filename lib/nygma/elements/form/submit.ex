defmodule Nygma.Elements.Form.Submit do
  use Schemata

  @primary_key false

  defschema do
    field :value, :string, default: ""
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Form.Submit do
  alias Nygma.Template

  def render(submit, context) do
    %{
      "type" => "submit",
      "value" => Template.inject(submit.value, context)
    }
  end
end
