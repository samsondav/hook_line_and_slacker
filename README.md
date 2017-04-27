# HookLineAndSlacker

You must provide your slack token using the SLACK_TOKEN=XXX env variable (you can get a token [here](https://api.slack.com/custom-integrations/legacy-tokens)).

To start the app:

  * Install dependencies with `mix deps.get`
  * Start web server with `iex -S mix`

Sanity check:

Visit [`localhost:4000/zz/health`](http://localhost:4000) in your browser, you should see some JSON.

## Tests

Run `mix test`

## Deployment

An example version is deployed [on heroku](https://peaceful-journey-12006.herokuapp.com/zz/health).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `hook_line_and_slacker` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:hook_line_and_slacker, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/hook_line_and_slacker](https://hexdocs.pm/hook_line_and_slacker).

