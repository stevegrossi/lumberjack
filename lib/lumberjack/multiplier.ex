# A Producer-Consumer
defmodule Lumberjack.Multiplier do
  alias Experimental.GenStage
  use GenStage

  def start_link(factor) do
    GenStage.start_link(__MODULE__, factor, name: __MODULE__)
  end

  # Callbacks

  def init(factor) do
    {:producer_consumer, factor, subscribe_to: [Lumberjack.Reader]}
  end

  def handle_events(events, _from, factor) do
    events = Enum.map(events, &(&1 * factor))
    {:noreply, events, factor}
  end
end
