use Mix.Config

config :hook_line_and_slacker, port: System.get_env("PORT") || 80

# Do not print debug messages in production
config :logger, level: :info
