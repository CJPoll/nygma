defmodule Nygma.PubSub do
  def publish(topic, message) do
    Phoenix.PubSub.broadcast(__MODULE__, topic, message)
  end

  def subscribe(topic) do
    Phoenix.PubSub.subscribe(__MODULE__, topic)
  end
end

defmodule Nygma.TestSubscriber do
  def start_link(topic) do
    spawn(__MODULE__, :run, [topic])
  end

  def run(topic) do
    Nygma.PubSub.subscribe(topic)

    do_run()
  end

  defp do_run do
    receive do
      {:content_changed, interaction_id, content} ->
        IO.inspect(~s"""
        Interaction #{interaction_id} changed its content to:
        #{inspect(content)}
        """)
    end

    do_run()
  end
end
