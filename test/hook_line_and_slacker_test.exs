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

  test "pull request opened webhook" do
    body = File.read!("./test/fixtures/pull_request_opened.json")
    conn = conn(:post, "/callbacks/github", body)
      |> put_req_header("content-type", "application/json")

    with_mock Slackex.Chat, [post_message: fn(_channel, _message) -> :ok end] do
      conn = HookLineAndSlacker.WebhookListener.call(conn, @opts)

      assert called Slackex.Chat.post_message(
        "test-channel",
        "baxterthehacker opened a pull request - " <>
        "<https://github.com/baxterthehacker/public-repo/pull/1|"<>
        "Update the README with new information>"
      )

      assert conn.state == :sent
      assert(conn.status == 204)
    end
  end

  test "pull request closed webhook" do
    body = File.read!("./test/fixtures/pull_request_closed.json")
    conn = conn(:post, "/callbacks/github", body)
      |> put_req_header("content-type", "application/json")

    with_mock Slackex.Chat, [post_message: fn(_channel, _message) -> :ok end] do
      conn = HookLineAndSlacker.WebhookListener.call(conn, @opts)

      assert called Slackex.Chat.post_message("test-channel", "Pull request was closed - <https://github.com/baxterthehacker/public-repo/pull/1|Update the README with new information>")

      assert conn.state == :sent
      assert(conn.status == 204)
    end
  end

  test "pull request merged webhook" do
    body = File.read!("./test/fixtures/pull_request_merged.json")
    conn = conn(:post, "/callbacks/github", body)
      |> put_req_header("content-type", "application/json")

    with_mock Slackex.Chat, [post_message: fn(_channel, _message) -> :ok end] do
      conn = HookLineAndSlacker.WebhookListener.call(conn, @opts)

      assert called Slackex.Chat.post_message("test-channel", "Pull request was merged - <https://github.com/baxterthehacker/public-repo/pull/1|Update the README with new information>")

      assert conn.state == :sent
      assert(conn.status == 204)
    end
  end
end
