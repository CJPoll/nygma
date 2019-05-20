defmodule Nygma.ExampleSteps.Turnstile do
  use Nygma.Step,
    fields: []

  alias Nygma.Elements.Text

  def transition_events, do: [:lock, :unlock, :ignore, :enter, :skip]

  def render(%{state: :locked}) do
    Text.from_map(%{text: "Locked"})
  end

  def render(%{state: :unlocked}) do
    Text.from_map(%{text: "Open"})
  end

  def on_enter(context) do
    Map.update(context, :state, :locked, fn _ -> :locked end)
  end

  def on_exit(context) do
    Map.delete(context, :state)
  end

  def handle_event(:lock, %{state: :locked} = context) do
    {:ignore, context}
  end

  def handle_event(:lock, %{state: :unlocked} = context) do
    {:lock, lock(context)}
  end

  def handle_event(:unlock, %{state: :locked} = context) do
    {:unlock, unlock(context)}
  end

  def handle_event(:unlock, %{state: :unlocked} = context) do
    {:ignore, context}
  end

  def handle_event(:enter, %{state: :locked} = context) do
    {:ignore, context}
  end

  def handle_event(:enter, %{state: :unlocked} = context) do
    {:enter, lock(context)}
  end

  def handle_event(_event, context) do
    {:ignore, context}
  end

  defp lock(context) do
    %{context | state: :locked}
  end

  defp unlock(context) do
    %{context | state: :unlocked}
  end
end
