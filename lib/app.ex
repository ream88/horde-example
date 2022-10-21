defmodule App do
  def start_worker(name) do
    Horde.DynamicSupervisor.start_child(App.WorkerSupervisor, {App.Worker, [name]})
  end

  def workers() do
    Horde.DynamicSupervisor.which_children(App.WorkerSupervisor)
  end
end
