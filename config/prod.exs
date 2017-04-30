use Mix.Config

port =
  case System.get_env("PORT") do
    port when is_binary(port) -> String.to_integer(port)
    nil -> 80 # default port
  end

config :hook_line_and_slacker, port: port

# Do not print debug messages in production
config :logger, level: :info
