use Mix.Config

config :hook_line_and_slacker, channel: System.get_env("CHANNEL")

import_config "#{Mix.env}.exs"
