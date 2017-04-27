defmodule SlackInteractor do
  def notify_pull_request_submitted(title, url) do
    message = "Pull request submitted - <#{url}|#{title}>"
    Slackex.Chat.post_message(channel(), message)
  end

  defp channel do
    System.get_env("CHANNEL")
  end
end
