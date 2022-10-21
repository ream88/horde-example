defmodule App.Worker do
  use GenServer, restart: :transient
  require Logger

  def start_link([name]) do
    case GenServer.start_link(__MODULE__, name, name: via_tuple(name)) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Logger.info("Already started #{name} at #{inspect(pid)}, returning :ignore")
        :ignore
    end
  end

  def init(name) do
    Process.send_after(self(), :tick, 1000)
    {:ok, {name, 0}}
  end

  def handle_info(:tick, {name, count}) do
    count = count + 1
    Logger.info("#{name} (#{inspect(self())}): #{count}")

    Process.send_after(self(), :tick, 1000)
    {:noreply, {name, count}}
  end

  def via_tuple(name), do: {:via, Horde.Registry, {App.WorkerRegistry, name}}
end
