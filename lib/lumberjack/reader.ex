# The Producer
defmodule Lumberjack.Reader do
  alias Experimental.GenStage
  use GenStage

  def start_link(log_path) do
    state = {0, log_path}
    GenStage.start_link(__MODULE__, state, name: __MODULE__)
  end

  # Callbacks

  def init({counter, log_path}) do
    log = File.stream!(log_path)
    {:producer, {counter, log}}
  end

  def handle_demand(demand, {counter, log}) do
    lines =
      log
      |> Stream.drop(counter)
      |> Enum.take(demand)

    {:noreply, lines, {counter + demand, log}}
  end
end
