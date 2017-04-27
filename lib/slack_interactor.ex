defmodule SlackInteractor do
  require Logger

  def notify_from_github_event(%{"action" => action, "pull_request" => pull_request}) do
    notify_pull_request(action, pull_request)
  end
  def notify_from_github_event(%{"zen" => zen}) do
    Logger.info(zen)
    :ok
  end
  def notify_from_github_event(_) do
    Logger.debug("Unhandled event")
    :ok
  end

  defp notify_pull_request("opened", pull_request) do
    %{"html_url" => url, "title" => title, "user" => %{"login" => username}} = pull_request
    message = "#{username} opened a pull request - <#{url}|#{title}>"
    Slackex.Chat.post_message(channel(), message)
    :ok
  end
  defp notify_pull_request("closed", pull_request) do
    %{"html_url" => url, "title" => title, "merged" => merged?} = pull_request
    closed_or_merged =
      if merged? do
        "merged"
      else
        "closed"
      end
    message = "Pull request was #{closed_or_merged} - <#{url}|#{title}>"
    Slackex.Chat.post_message(channel(), message)
    :ok
  end
  defp notify_pull_request(action, _pull_request) do
    Logger.info("Unhandled pull request action: #{action}")
    :ok
  end

  defp channel do
    Application.fetch_env!(:hook_line_and_slacker, :channel)
  end
end
