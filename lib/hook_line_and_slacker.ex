defmodule HookLineAndSlacker do
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(HookLineAndSlacker.WebhookListener, [])
    ]

    opts = [strategy: :one_for_one, name: HexVersion.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def version do
    HookLineAndSlacker.Mixfile.project[:version]
  end

  def port do
    case System.get_env("PORT") do
      nil -> 4000
      port -> String.to_integer(port)
    end
  end
end
