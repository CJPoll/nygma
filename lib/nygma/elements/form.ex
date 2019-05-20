defmodule Nygma.Elements.Form do
  use Schemata

  @primary_key false

  defschema do
    field :children, {:array, Nygma.Child}
  end
end

defimpl Nygma.Renderable, for: Nygma.Elements.Form do
  def render(form, context) do
    %{
      "type" => "form",
      "children" => Nygma.Renderable.render(form.children, context)
    }
  end
end
