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
    Logger.info "Callback received: #{conn.body_params}"
    case conn.body_params do
      %{"action" => "submitted", "pull_request" => %{"url" => url, "title" => title }} ->
        Logger.info "Pull request submitted: #{title}, #{url}"
        SlackInteractor.notify_pull_request_submitted(title, url)
      _ping = %{"zen" => zen} -> Logger.info(zen)
      _ -> :ok
    end
    send_resp(conn, 204, "")
  end

  match _ do
    conn
    |> send_resp(404, "Nothing here")
    |> halt
  end
end
