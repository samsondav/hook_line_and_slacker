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

  @doc "The application version, taken from mix.exs"
  def version do
    HookLineAndSlacker.Mixfile.project[:version]
  end

  @doc "Port that the web server should listen on"
  def port do
    case Application.fetch_env!(:hook_line_and_slacker, :port) do
      port when is_binary(port) -> String.to_integer(port)
      port -> port
    end
  end
end
