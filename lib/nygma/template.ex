defmodule Nygma.Template do
  def inject(template, context) do
    {:ok, str, _} =
      template
      |> Liquid.Template.parse
      |> Liquid.Template.render(context)

    str
  end
end
