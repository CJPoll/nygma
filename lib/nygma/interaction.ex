defmodule Nygma.Interaction do
  use GenServer
  alias Nygma.TransitionGraph

  @type context :: term
  @type step :: term
  @type initial_step :: step
  @type current_step :: step
  @type event :: term

  @callback init(term) :: {context, initial_step}

  defmodule State do
    defstruct [:context, :step, :transition_graph]

    def new(context, step, transition_graph) do
      %__MODULE__{
        context: context,
        step: step,
        transition_graph: transition_graph
      }
    end
  end

  # Public Functions

  def trigger(pid, event) do
    GenServer.cast(pid, {:event, event})
  end

  def start_link(context, transition_graph) do
    GenServer.start_link(__MODULE__, {context, transition_graph})
  end

  # Callback Functions

  def init({context, transition_graph}) do
    unless TransitionGraph.complete?(transition_graph) do
      raise "Incomplete transition graph"
    end

    step = TransitionGraph.initial_state(transition_graph)

    IO.inspect("Calling #{inspect(step)}.on_enter/1 with context: #{inspect(context)}")

    state =
      case step.on_enter(context) do
        {transition_event, context} ->
          IO.inspect(
            "#{inspect(step)}.on_enter/1 triggered #{inspect(transition_event)}, with context: #{
              inspect(context)
            }"
          )

          context
          |> State.new(step, transition_graph)
          |> transition(transition_event, context)

        context ->
          IO.inspect("#{inspect(step)} returned with context: #{inspect(context)}")
          State.new(context, step, transition_graph)
      end

    {:ok, state}
  end

  def handle_cast(
        {:event, event},
        %State{step: step, context: context} = state
      ) do
    IO.inspect(
      "#{step} receiving client_event: #{inspect(event)} with context: #{inspect(context)}"
    )

    {transition_event, context} = step.handle_event(event, context)

    IO.inspect(
      "#{step} triggered transition_event: #{inspect(transition_event)} with context: #{
        inspect(context)
      }"
    )

    {:noreply, transition(state, transition_event, context)}
  end

  defp transition(state, transition_event, context) do
    unless transition_event in state.step.transition_events do
      raise "#{state.step} returned an unregistered response: #{inspect(transition_event)}"
    end

    case TransitionGraph.transition(state.transition_graph, state.step, transition_event) do
      :stay ->
        %State{state | context: context}

      new_step ->
        do_transition(state, new_step, context)
    end
  end

  defp do_transition(%State{} = state, next_step, context) do
    IO.inspect("Calling #{inspect(state.step)}.on_exit/1 with context: #{inspect(context)}")
    context = state.step.on_exit(context)
    IO.inspect("Calling #{inspect(next_step)}.on_enter/1 with context: #{inspect(context)}")
    result = next_step.on_enter(context)

    case result do
      {transition_event, context} ->
        IO.inspect(
          "#{inspect(next_step)}.on_enter/1 triggered #{inspect(transition_event)}, with context: #{
            inspect(context)
          }"
        )

        state = %State{state | context: context, step: next_step}
        transition(state, transition_event, context)

      context ->
        IO.inspect("#{inspect(next_step)}.on_enter/1 returned context: #{inspect(context)}")
        %State{state | context: context, step: next_step}
    end
  end
end
