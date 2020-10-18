defmodule Freecodecamp.MixProject do
  use Mix.Project

  def project do
    [
      app: :freecodecamp,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),

      # Docs
      name: "FCC using Elixir",
      source_url: "https://github.com/jaeyson/freecodecamp-exercises-using-elixir",
      docs: [
        authors: ["Jaeyson Anthony Y."],
        api_reference: false,
        assets: "assets",
        main: "Freecodecamp",
        logo: "assets/static/images/logo.png"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:stream_data, "~> 0.4.3"},
      {:ex_doc, "~> 0.23.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.5.1", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases do
    [
      test: [
        "format --check-formatted",
        "test --trace",
        # "dialyzer",
        "credo --strict"
      ]
    ]
  end
end
