defmodule Freecodecamp.MixProject do
  use Mix.Project

  def project do
    [
      app: :freecodecamp,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:ex_doc, "~> 0.21.2", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false}
    ]
  end
end
