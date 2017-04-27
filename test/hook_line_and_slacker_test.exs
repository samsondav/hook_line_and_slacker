defmodule HookLineAndSlackerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  doctest HookLineAndSlacker

  @opts HookLineAndSlacker.WebhookListener.init([])

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
end
