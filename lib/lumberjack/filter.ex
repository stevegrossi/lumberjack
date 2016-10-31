# A Producer-Consumer
defmodule Lumberjack.Filter do
  alias Experimental.GenStage
  use GenStage

  @regex ~r/Completed 200 OK in (\d+)ms/

  def start_link do
    GenStage.start_link(__MODULE__, :whatever, name: __MODULE__)
  end

  # Callbacks

  def init(state) do
    {:producer_consumer, state, subscribe_to: [Lumberjack.Reader]}
  end

  def handle_events(events, _from, state) do
    filtered_events =
      events
      |> Enum.map(&extract_metric(&1))
      |> Enum.reject(&is_nil(&1))

    {:noreply, filtered_events, state}
  end

  defp extract_metric(line) do
    detect_match(Regex.run(@regex, line))
  end

  defp detect_match([_line, match]), do: String.to_integer(match)
  defp detect_match(_), do: nil
end
