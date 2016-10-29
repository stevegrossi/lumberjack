# The Producer
defmodule Lumberjack.Reader do
  alias Experimental.GenStage
  use GenStage

  def start_link(state) do
    GenStage.start_link(__MODULE__, state)
  end

  # Callbacks

  def init(state) do
    {:producer, state}
  end

  def handle_demand(demand, state) do
    # 0..4 => [0, 1, 2, 3, 4]
    # 5..9 => [5, 6, 7, 8, 9] => 5
    events = Enum.to_list(state..state+demand-1)
    new_state = state + demand
    {:noreply, events, new_state}
  end
end
