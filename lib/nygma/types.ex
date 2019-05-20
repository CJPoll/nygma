defmodule Nygma.Types do
  alias Nygma.Elements.{
    Heading,
    Image,
    Link,
    Text,
    Form,
    Form.Label,
    Form.TextInput
  }

  @type_mapping %{
    "heading" => Heading,
    "image" => Image,
    "link" => Link,
    "text" => Text,
    "form" => Form,
    "label" => Label,
    "text_input" => TextInput
  }

  @spec module(String.t) :: nil | module
  def module(type) do
    @type_mapping[type]
  end
end
