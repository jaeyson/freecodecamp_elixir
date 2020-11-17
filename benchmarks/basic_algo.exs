defmodule Benchmark.BasicAlgo do
  # require Logger

  @spec run(String.t, module(), any()) :: module()
  def run(function_name, formatter, args \\ nil),
    do: __MODULE__ |> apply(String.to_atom(function_name), [formatter, args])

  @spec mutation(module(), any()) :: module()
  def mutation(formatter, _args) do
    Benchee.run(
      %{
        "mutation_version_one" => &mutation_gen(&1, :version_one),
        "mutation_version_two" => &mutation_gen(&1, :version_two)
      },
      before_each: fn _ -> [mutation_input(), mutation_input()] end,
      time: 5,
      memory_time: 2,
      warmup: 4,
      formatters: [formatter]
    )
  end

  @spec mutation_gen(list(String.t), atom()) :: boolean()
  defp mutation_gen([target, source] = _list, version) do
    case version do
      :version_one ->
        ver_one = mutation_list(target) |> Enum.filter(& &1 in mutation_list(source))

        ver_one === mutation_list(source)

      :version_two ->
        ver_two = for el <- mutation_list(target), el in mutation_list(source), do: el

        ver_two === mutation_list(source)

      _no_version ->
        false
    end
  end

  @spec mutation_list(String.t) :: list(String.t)
  defp mutation_list(string) do
    String.downcase(string)
      |> String.split("", trim: true)
      |> Enum.uniq()
      |> Enum.sort()
  end

  @spec mutation_input :: String.t
  defp mutation_input do
    :alphanumeric
    |> StreamData.string([min_length: 3, max_length: 20])
    |> Enum.take(30)
    |> Enum.random
  end

end

alias Benchmark.BasicAlgo
alias Benchee.Formatters.{HTML, Console}

BasicAlgo.run("mutation", Console)

# Available functions:
#   - mutation
