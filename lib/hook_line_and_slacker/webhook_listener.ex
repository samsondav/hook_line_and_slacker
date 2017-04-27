defmodule HookLineAndSlacker.WebhookListener do
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json], json_decoder: Poison
  plug :match
  plug :dispatch

  def init(options) do
    options
  end

  def start_link do
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [], port: HookLineAndSlacker.port)
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

  post "/callbacks/github" do
    case SlackInteractor.notify_from_github_event(conn.body_params) do
      :ok -> send_resp(conn, 204, "")
      :error -> send_resp(conn, 500, "")
    end
  end

  match _ do
    conn
    |> send_resp(404, "Nothing here")
    |> halt
  end
end
