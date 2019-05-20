defmodule Nygma.ExampleInteractions.TestInteraction do
  alias Nygma.{Interaction, TransitionGraph}
  alias Nygma.ExampleSteps.{Inventory, Turnstile}

  def start_link(context) do
    transition_graph =
      TransitionGraph.new()
      |> TransitionGraph.add_nodes([Turnstile, Inventory])
      |> TransitionGraph.initial_state!(Turnstile)
      |> TransitionGraph.add_transitions!(Turnstile,
        lock: :stay,
        unlock: :stay,
        ignore: :stay,
        enter: Inventory,
        skip: Inventory
      )
      |> TransitionGraph.add_transitions!(Inventory,
        ignore: :stay,
        exit: Turnstile
      )

    Interaction.start_link(context, transition_graph)
  end
end
