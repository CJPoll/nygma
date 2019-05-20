defmodule Nygma.Child do
  alias Nygma.Types
  @behaviour Ecto.Type

  def type, do: :map

  def cast(%{type: type} = params) do
    module = Types.module(type)
    module.from_map(params)
  end

  def cast(%{"type" => type} = params) do
    module = Types.module(type)
    module.from_map(params)
  end

  def cast(data) do
    IO.inspect(data, label: "Invalid Cast")
    :error
  end

  def dump(_), do: raise "Undefined dump"
  def load(_), do: raise "Undefined load"
end
