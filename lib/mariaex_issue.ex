defmodule MariaexIssue do
  @moduledoc false

  use Application

  require Logger

  alias MariaexIssue.{Product, Repo}

  def start(_type, _args) do
    # Start supervisor
    import Supervisor.Spec, warn: false

    children = [
      worker(Repo, []),
    ]

    opts = [strategy: :one_for_one, name: MasterProxy.Supervisor]
    supervisor = Supervisor.start_link(children, opts)

    reproduce()

    supervisor
  end

  def reproduce do
    Logger.debug "Inserting Product without name"
    product = %Product{} |> Repo.insert! |> IO.inspect

    Logger.debug "Insert result: #{inspect product}"

    Logger.debug "List all products in db: #{inspect Repo.all(Product)}"
  end
end
