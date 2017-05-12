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
    port = Application.fetch_env!(:hook_line_and_slacker, :port)
    {:ok, _} = Plug.Adapters.Cowboy.http(__MODULE__, [], port: port)
  end

  get "/zz/health" do
    body = %{
      status: :ok,
      version: version(),
    }
    conn
    |> send_resp(200, Poison.encode!(body))
    |> halt
  end

  post "/callbacks/github" do
    case SlackInteractor.notify_from_github_event(conn.body_params) do
      :ok -> send_resp(conn, 204, "")
    end
  end

  match _ do
    conn
    |> send_resp(404, "Nothing here")
    |> halt
  end

  defp version do
    HookLineAndSlacker.Mixfile.project[:version]
  end
end
