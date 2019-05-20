defmodule Nygma.ExampleSteps.Inventory do
  use Nygma.Step,
    fields: []

  alias Nygma.Elements.Text

  def transition_events, do: [:exit, :ignore]

  def render(_context) do
    Text.from_map(%{text: "Inventory!"})
  end

  def handle_event(:exit, %{} = context) do
    {:exit, context}
  end

  def handle_event(_, %{} = context) do
    {:ignore, context}
  end
end
