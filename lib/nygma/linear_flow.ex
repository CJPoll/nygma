defmodule Nygma.LinearFlow do
  alias Nygma.TransitionGraph

  # Public API

  def build(flow) when is_list(flow) do
    graph = TransitionGraph.add_nodes(TransitionGraph.new(), steps(flow))

    Enum.reduce(flow, graph, fn step, graph ->
      add_transitions(step, graph, flow)
    end)
  end

  # Private Functions

  defp add_transitions({action, next_step} = e, graph, flow) do
    current_index = Enum.find_index(flow, &(&1 == e))
    last_step = Enum.at(steps(flow), current_index - 1)

    map1 = build_map(last_step, action, next_step)
    map2 = build_map(next_step, nil, nil)

    graph
    |> TransitionGraph.add_transitions!(last_step, map1)
    |> TransitionGraph.add_transitions!(next_step, map2)
  end

  defp add_transitions(step, graph, _flow) do
    graph
    |> TransitionGraph.initial_state!(step)
    |> TransitionGraph.add_transitions!(step, build_map(step, nil, nil))
  end

  defp build_map(last_step, _action, nil) do
    last_step.transition_events
    |> Enum.map(&{&1, :stay})
    |> Map.new()
  end

  defp build_map(last_step, action, next_step) do
    last_step.transition_events
    |> Enum.map(&{&1, :stay})
    |> Map.new()
    |> Map.update(action, next_step, fn _ -> next_step end)
  end

  defp steps(flow) do
    Enum.map(flow, fn
      {_action, step} -> step
      step -> step
    end)
  end
end
