defmodule HookLineAndSlackerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest HookLineAndSlacker

  @opts HookLineAndSlacker.WebhookListener.init([])

  import Mock

  test "/zz/health returns health info" do
    # Create a test connection
    conn = conn(:get, "/zz/health")

    # Invoke the plug
    conn = HookLineAndSlacker.WebhookListener.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert Poison.decode!(conn.resp_body) == %{"status" => "ok", "version" => "0.1.0"}
  end

  test "pull request submitted webhook" do
    body = File.read!("./test/fixtures/pull_request_submitted.json")
    conn = conn(:post, "/callbacks/github", body)
      |> put_req_header("content-type", "application/json")

    with_mock SlackInteractor, [notify_pull_request_submitted: fn(_title, _url) -> :ok end] do
      conn = HookLineAndSlacker.WebhookListener.call(conn, @opts)

      assert called SlackInteractor.notify_pull_request_submitted("Add a README description", "https://api.github.com/repos/baxterthehacker/public-repo/pulls/8")

      assert conn.state == :sent
      assert(conn.status == 204)
    end
  end
end
