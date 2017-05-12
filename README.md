# HookLineAndSlacker

You must provide the following ENV variables:

  * SLACK_TOKEN=your-slack-token (you can get a token [here](https://api.slack.com/custom-integrations/legacy-tokens)).
  * CHANNEL=channel-name (the name of the slack channel to post to)

To start the app:

  * Install dependencies with `mix deps.get`
  * Start web server with `iex -S mix`

Sanity check:

Visit [`localhost:4000/zz/health`](localhost:4000/zz/health) in your browser, you should see some JSON.

## Tests

Run `mix test`
