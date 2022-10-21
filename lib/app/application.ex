defmodule App.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies)

    children = [
      # Starts a worker by calling: App.Worker.start_link(arg)
      # {App.Worker, arg}
      {Cluster.Supervisor, [topologies, [name: App.ClusterSupervisor]]},
      {Horde.Registry, [name: App.WorkerRegistry, keys: :unique]},
      {Horde.DynamicSupervisor,
       [name: App.WorkerSupervisor, strategy: :one_for_one, members: :auto]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
