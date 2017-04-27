defmodule HookLineAndSlacker.WebhookListener do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [])
  end

  get "/zz/health" do
    body = %{
      status: :ok,
      version: HookLineAndSlacker.version,
    }
    conn
    |> send_resp(200, Poison.encode!(body))
    |> halt
  end
end
