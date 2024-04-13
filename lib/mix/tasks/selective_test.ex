defmodule Mix.Tasks.SelectiveTest do
  @moduledoc """
  ## Usage

  `mix selective_test [module, ...]`

  Running e.g. `mix selective_test basic_algo` will
  only include tests from `test/basic_algo_test.exs`.
  Note: these command is not to be ran inside `iex`,
  rather run this in your OS shell.

  To view this via terminal:
  ```bash
  mix help selective_test
  ```

  ## Example

  Another way to call it:
  ```bash
  # specific test
  mix selective_test basic_algo

  # two or more
  mix test --exclude intermediate_algo basic_algo
  ```

  """
  @moduledoc since: "0.1.0"
  @shortdoc "Selects 1 or more modules to be tested."

  use Mix.Task

  @modules [
    "basic_algo",
    "intermediate_algo"
  ]

  @impl Mix.Task
  @spec run([String.t()]) :: IO.puts()
  def run([]) do
    """
    Please add one or more module name, separated by spaces.

    e.g. run test on basic_algo and algo_projects only

    mix selective_test basic_algo algo_projects
    """
    |> IO.puts()
  end

  def run(args) do
    args = Enum.filter(args, &(&1 !== "" && &1 !== nil))
    excluded_modules = Enum.filter(@modules, &(&1 not in args))

    case excluded_modules === [] do
      true ->
        run_mix_test(@modules, "--include")

      false ->
        run_mix_test(excluded_modules, "--exclude")
    end
  end

  @spec run_mix_test([String.t()], String.t()) :: IO.puts()
  defp run_mix_test(excluded_modules, option) do
    excluded_modules =
      excluded_modules
      |> Enum.map(&[option, &1])
      |> List.flatten()

    System.cmd("mix", ["test" | excluded_modules], stderr_to_stdout: true)
    |> elem(0)
    |> IO.puts()
  end
end
