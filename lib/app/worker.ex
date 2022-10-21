defmodule App.Worker do
  use GenServer, restart: :transient
  require Logger

  def start_link([name]) do
    case GenServer.start_link(__MODULE__, [], name: via_tuple(name)) do
      {:ok, pid} ->
        {:ok, pid}

      {:error, {:already_started, pid}} ->
        Logger.info("Already started at #{inspect(pid)}, returning :ignore")
        :ignore
    end
  end

  def init(_args) do
    {:ok, nil}
  end

  def via_tuple(name), do: {:via, Horde.Registry, {App.WorkerRegistry, name}}
end
