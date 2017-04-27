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

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     mod: {HookLineAndSlacker, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
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
