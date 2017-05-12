defmodule HookLineAndSlacker.Mixfile do
  use Mix.Project

  def project do
    [app: :hook_line_and_slacker,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger],
     mod: {HookLineAndSlacker, []}]
  end

  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.3"},
      {:poison, "~> 3.0"},
      {:slackex, "~> 0.0.1"},
      {:mock, "~> 0.2.0", only: :test},
    ]
  end
end
