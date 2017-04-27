defmodule HookLineAndSlacker do
  require Logger
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
    Application.fetch_env!(:hook_line_and_slacker, :port)
  end
end
