defmodule FreecodecampElixir.MixProject do
  use Mix.Project

  @version "0.2.0"
  @elixir_version "~> 1.9"
  @source_url "https://github.com/jaeyson/freecodecamp_elixir"
  @coverage_url "https://coveralls.io/github/jaeyson/freecodecamp_elixir"

  def project do
    [
      app: :freecodecamp_elixir,
      version: @version,
      elixir: @elixir_version,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      name: "Freecodecamp using Elixir",
      description:
        "Solving exercises from Freecodecamp.org using Elixir programming language. Includes benchmarks and tests for every functions.",
      source_url: @source_url,
      aliases: aliases(),
      deps: deps(),
      docs: docs(),
      package: package()
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
      {:stream_data, "~> 1.0", only: [:dev, :test]},
      {:benchee, "~> 1.0", only: [:dev], runtime: false},
      {:benchee_html, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.32", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test}
    ]
  end

  defp aliases do
    [
      test: [
        "format --check-formatted",
        "test --trace",
        "credo --strict --all"
      ]
    ]
  end

  defp docs do
    [
      main: "readme",
      extra_section: "PAGES",
      authors: ["Jaeyson Anthony Y."],
      api_reference: false,
      # assets: "assets",
      # logo: "assets/static/images/logo.png",
      source_ref: "v#{@version}",
      source_url: @source_url,
      canonical: "http://hexdocs.pm/freecodecamp_elixir",
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      extras: extras()
    ]
  end

  defp package do
    [
      maintainers: ["Jaeyson Anthony Y."],
      licenses: ["MIT"],
      links: %{
        "Github" => @source_url,
        "Test coverage" => @coverage_url
      }
    ]
  end

  defp extras do
    [
      "README.md",
      "CHANGELOG.md",
      "LICENSE"
    ]
  end
end
