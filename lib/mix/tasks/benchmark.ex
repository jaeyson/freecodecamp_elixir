defmodule Mix.Tasks.Benchmark do
  @moduledoc """
  ## Usage

  `mix benchmark [module, ...] [options] `

  Running e.g. `mix selective_test basic_algo` will
  only include tests from `test/basic_algo_test.exs`.
  Note: these command is not to be ran inside `iex`,
  rather run this in your OS shell.

  To view this via terminal:
  ```bash
  mix help benchmark
  ```

  ## Options

  - `--list`: Lists available functions
  - `--console`: Outputs benchmark result in terminal (Default).
  - `--html`: Outputs benchmark as html doc

  ## Example

  ```bash
  # list available functions
  mix benchmark --list
  ```

  ```bash
  # specific function
  mix benchmark mutation
  ```

  ```bash
  # benchmark specific function, export to html
  mix benchmark mutation --html
  ```

  """
  @moduledoc since: "0.2.0"
  @shortdoc "Benchmarks a specific function"

  use Mix.Task

  @formatter ~w(--html --console)
  @benchmarks "Benchmarks"

  @impl Mix.Task
  @spec run([String.t()]) :: IO.puts()
  def run(["--list"]) do
    functions = list_available_functions() |> Map.values() |> List.flatten()
    available_functions = Enum.map_join(functions, "\n", &("- " <> to_string(&1)))
    specific_function = Enum.random(functions)

    """
    Here's the list of available modules:
    #{available_functions}

    To run specific module:
    $ mix benchmark #{specific_function}

    To run and export result to html:
    $ mix benchmark #{specific_function} --html
    """
    |> IO.puts()
  end

  @spec run(list(String.t())) :: IO.puts() | Benchee.Suite.t()
  def run(args) do
    all_fns = list_available_functions() |> Map.values() |> List.flatten()

    case Enum.all?(args, &(&1 in all_fns or &1 in @formatter)) do
      true ->
        formatter = Enum.find(args, &(&1 in @formatter)) || "console"
        function = Enum.filter(args, &(&1 in all_fns)) |> hd()
        mod = find_module(function)

        mod.run(function, formatter)

      false ->
        IO.puts(~s(Error: invalid arguments. See "mix help benchmark" for instructions))
    end
  end

  @spec find_module(String.t()) :: module()
  defp find_module(function) do
    {mod, _functions} =
      list_available_functions()
      |> Enum.find(fn {_mod, functions} -> function in functions end)

    mod
  end

  @spec list_available_functions :: %{module() => list(String.t())}
  defp list_available_functions do
    {:ok, modules} = :application.get_key(:freecodecamp_elixir, :modules)

    modules
    |> Enum.filter(fn module ->
      case Module.split(module) do
        [_app_name, _namespace] -> true
        _ -> false
      end
    end)
    |> Enum.group_by(
      fn module ->
        [app_name, base] = module |> Module.split()
        app_name |> Module.concat(@benchmarks) |> Module.concat(base)
      end,
      fn module ->
        module.__info__(:functions) |> Keyword.keys() |> Enum.map(&to_string/1)
      end
    )
    |> Enum.reduce(%{}, fn {module, functions}, acc ->
      Map.put(acc, module, List.flatten(functions))
    end)
  end
end
