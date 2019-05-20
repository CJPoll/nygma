defmodule Nygma.ExampleInteractions.Linear do
  alias Nygma.{Interaction, LinearFlow}
  alias Nygma.ExampleSteps.{Inventory, Turnstile, Skipper}

  def start_link(context) do
    transition_graph =
      LinearFlow.build([Skipper, skip: Skipper, skip: Turnstile, enter: Inventory])

    Interaction.start_link(context, transition_graph)
  end
end
