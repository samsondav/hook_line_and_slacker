defmodule SlackInteractor do
  require Logger

  def notify_from_github_event(event) do
    case event do
      %{"action" => "opened", "pull_request" => pull_request} ->
        notify_pull_request_opened(pull_request)
      _ping = %{"zen" => zen} ->
        Logger.debug(zen)
        :ok
      _ -> :ok
    end
  end

  defp notify_pull_request_opened(pull_request) do
    %{"url" => url, "title" => title, "user" => %{"login" => username}} = pull_request
    message = "#{username} submitted a pull request - <#{url}|#{title}>"
    Slackex.Chat.post_message(channel(), message)
  end

  defp channel do
    System.get_env("CHANNEL")
  end
end
