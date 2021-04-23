defmodule Inmana.Supplies.Scheduler do
  use GenServer

  alias Inmana.Supplies.ExpirationNotification

  def start_link(_state) do
    GenServer.start_link(__MODULE__, %{})
  end

  # initialize
  # GenServer.start(Scheduler, %{})
  # def init(state \\ %{}) do
  #   {:ok, state}
  # end

  @impl true
  def init(state \\ %{}) do
    schedule_notification()
    {:ok, state}
  end

  # async
  # GenServer.cast(pid, {:put, :a, 1})
  # def handle_cast({:put, key, value}, state) do
  #   {:noreply, Map.put(state, key, value)}
  # end

  # sync
  # GenServer.call(pid, {:get, :a})
  # def handle_call({:get, key}, _from, state) do
  #   {:reply, Map.get(state, key), state}
  # end

  # send(pid, "message")
  # def handle_info(msg, state) do
  #   {:noreply, state}
  # end

  @impl true
  def handle_info(:generate, state) do
    ExpirationNotification.send()

    schedule_notification()

    {:noreply, state}
  end

  defp schedule_notification do
    Process.send_after(self(), :generate, 1000 * 10)
  end
end
