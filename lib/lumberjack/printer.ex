# The Consumer
defmodule Lumberjack.Printer do
  alias Experimental.GenStage
  use GenStage

  def start_link do
    # Consumers don’t care about the state of the event source
    GenStage.start_link(__MODULE__, :whatever)
  end

  # Callbacks

  def init(counter) do
    {:consumer, counter, subscribe_to: [Lumberjack.Reader]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect {self(), event}
    end

    # Consumers don’t publish events, so this is empty.
    # This argument exists for interface uniformity with
    # other GenStage types, e.g. [:producer, :producer_consumer]
    events = []

    # Consumers don’t care about the state either
    {:noreply, events, state}
  end
end
