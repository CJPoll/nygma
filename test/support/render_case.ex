use Schemata

defnamespace Nygma.Render do
  defschema Definition do
    field :id, :string
    field :name, :string
    field :content_type, :string, default: "element"
    field :type, :string, default: "text"
    field :text, :string

    def to_element(%__MODULE__{} = definition) do
      Nygma.Elements.create(definition.type, definition |> Map.from_struct())
    end
  end

  defschema Context do
    field :params, :map, default: %{}
    field :headers, :map, default: %{}
  end

  defschema Test do
    field :name, :string, required: true

    has_one :result, namespaced(Definition)
    has_one :context, namespaced(Context)
  end

  defschema TestSuite do
    field :name, :string, required: true
    has_one :definition, namespaced(Definition)
    has_many :tests, namespaced(Test)
  end
end

defmodule Nygma.RenderCase do
  use ExUnit.CaseTemplate

  using(kwargs) do
    path = Keyword.get(kwargs, :path)

    {:ok, data} =
      (priv_dir() <> path)
      |> File.read!()
      |> IO.inspect()
      |> YamlElixir.read_from_string()
      |> IO.inspect()

    {:ok, test_suite} = Nygma.Render.TestSuite.from_map(data)

    element = test_suite.definition |> Nygma.Render.Definition.to_element() |> Macro.escape()

    tests =
      for test <- test_suite.tests do
        result = test.result |> Nygma.Render.Definition.to_element() |> Macro.escape()

        quote do
          test unquote(test.name), %{element: element} do
            assert unquote(result) ==
                     Nygma.Element.render(element, unquote(test.context |> Macro.escape()))
          end
        end
      end

    quote do
      setup do
        {:ok, %{element: unquote(element)}}
      end

      describe unquote(test_suite.name) do
        unquote(tests)
      end
    end
  end

  def priv_dir do
    :nygma
    |> :code.priv_dir()
    |> to_string
  end
end
