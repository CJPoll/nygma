defmodule Nygma.Step do
  defmacro __using__(args) do
    fields = Keyword.fetch!(args, :fields)

    quote do
      @behaviour unquote(__MODULE__)
      alias Nygma.Elements

      defstruct unquote(fields)

      def on_enter(context), do: context
      def on_exit(context), do: context

      def new(), do: %__MODULE__{}

      defoverridable on_enter: 1, on_exit: 1
    end
  end

  @type element :: term
  @type t :: element
  @type content :: map
  @type context :: map
  @type transition_event :: atom
  @type client_event :: atom

  @callback render(context) :: element
  @callback handle_event(client_event, context) :: {transition_event, context}
  @callback on_enter(context) :: context | {transition_event, context}
  @callback on_exit(context) :: context
  @callback transition_events :: [transition_event]
end
