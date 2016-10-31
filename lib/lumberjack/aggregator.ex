# The Consumer
defmodule Lumberjack.Aggregator do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    GenStage.start_link(__MODULE__, [])
  end

  # Callbacks

  def init(state) do
    {:consumer, state, subscribe_to: [Lumberjack.Filter]}
  end

  def handle_events(metrics, _from, state) do
    new_state = state ++ metrics

    IO.puts("Average: #{average(new_state)}")

    # Consumers don’t publish events, so this is empty.
    # This argument exists for interface uniformity with
    # other GenStage types, e.g. [:producer, :producer_consumer]
    events = []

    # Consumers don’t care about the state either
    {:noreply, events, new_state}
  end

  defp average(list) when is_list(list) do
    Enum.sum(list) / length(list)
  end
end
