defmodule Nygma.ExampleSteps.Skipper do
  use Nygma.Step,
    fields: []

  alias Nygma.Elements.Text

  def transition_events, do: [:skip, :ignore]

  def render(_context) do
    Text.from_map(%{text: "Inventory!"})
  end

  def on_enter(context) do
    {:skip, context}
  end

  def handle_event(_, %{} = context) do
    {:ignore, context}
  end
end
