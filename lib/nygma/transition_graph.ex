defmodule Nygma.TransitionGraph do
  defstruct([:initial_state, edges: %{}, nodes: MapSet.new()])

  def new do
    %__MODULE__{}
  end

  def add_node(%__MODULE__{nodes: nodes} = graph, step) do
    %__MODULE__{graph | nodes: MapSet.put(nodes, step)}
  end

  def add_nodes(%__MODULE__{} = graph, steps) do
    Enum.reduce(steps, graph, fn step, graph ->
      add_node(graph, step)
    end)
  end

  def add_transition!(%__MODULE__{edges: edges} = graph, from_step, event, to_step) do
    unless node?(graph, from_step) and (node?(graph, to_step) or to_step == :stay) do
      raise "Unknown node: From: #{inspect(from_step)}, To: #{inspect(to_step)}"
    end

    %__MODULE__{
      graph
      | edges: Map.update(edges, {from_step, event}, to_step, fn _ -> to_step end)
    }
  end

  def add_transitions!(%__MODULE__{} = graph, from_step, transitions) do
    Enum.reduce(transitions, graph, fn {event, to_step}, graph ->
      add_transition!(graph, from_step, event, to_step)
    end)
  end

  def complete?(%__MODULE__{nodes: nodes} = graph) do
    Enum.all?(nodes, fn node ->
      Enum.all?(node.transition_events, fn event ->
        transition?(graph, node, event)
      end)
    end)
  end

  def initial_state(%__MODULE__{initial_state: step}), do: step

  def initial_state!(%__MODULE__{} = graph, step) do
    unless node?(graph, step) do
      raise "Unknown node: Initial State: #{inspect(step)}"
    end

    %__MODULE__{graph | initial_state: step}
  end

  def node?(%__MODULE__{nodes: nodes}, step), do: step in nodes

  def transition?(%__MODULE__{edges: edges}, from_step, event) do
    to_step = Map.get(edges, {from_step, event})
    not is_nil(to_step)
  end

  def transition(%__MODULE__{edges: edges}, from_step, event) do
    Map.get(edges, {from_step, event})
  end
end
