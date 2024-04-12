defmodule FreecodecampElixir.Benchmarks.IntermediateAlgo do
  alias Benchee.Formatters.Console
  alias Benchee.Formatters.HTML
  alias FreecodecampElixir.IntermediateAlgo
  @moduledoc false

  # NOTE: We can't use apply/3 here to run a number of
  # arbitrary functions in order to minimize the use
  # of atoms. So we listed all (and future) functions.

  @spec run(String.t(), String.t()) :: module()
  def run(function_name, formatter \\ "--console") do
    case formatter do
      "--console" -> Console
      "--html" -> HTML
    end

    do_run(function_name, formatter)
  end

  # set config for benchmark here
  defp generic_benchee(map, formatter, before_each_function) do
    Benchee.run(
      map,
      before_each: before_each_function,
      time: 5,
      memory_time: 2,
      warmup: 4,
      formatters: [formatter]
    )
  end

  @spec do_run(String.t(), module()) :: module()
  defp do_run("sum_all", formatter) do
    generic_benchee(
      %{
        "IntermediateAlgo.sum_all" => fn {int1, int2} ->
          IntermediateAlgo.sum_all([int1, int2])
        end,
        "Enum.reduce" => fn {int1, int2} ->
          sum_all_gen([int1, int2])
        end,
        "Enum.sum" => fn {int1, int2} ->
          sum_all_gen_v2([int1, int2])
        end,
        "list comprehension" => fn {int1, int2} ->
          sum_all_gen_v3([int1, int2])
        end
      },
      formatter,
      fn _ ->
        {
          gen_int_input(10_000),
          gen_int_input(10_000)
        }
      end
    )
  end

  @spec do_run(String.t(), module()) :: module()
  defp do_run("diff_list", formatter) do
    generic_benchee(
      %{
        "IntermediateAlgo.diff_list" => fn {list1, list2} ->
          IntermediateAlgo.diff_list(list1, list2)
        end,
        "Enum.frequencies/1 && Enum.reduce/3" => fn {list1, list2} ->
          diff_list_gen(list1, list2)
        end
      },
      formatter,
      fn _ ->
        {
          gen_list_int_or_string(20),
          gen_list_int_or_string(20)
        }
      end
    )
  end

  ##################################################
  ### Below are helpers for the main functions above
  ##################################################

  @spec gen_list_int_or_string(pos_integer) :: integer()
  defp gen_list_int_or_string(number) do
    integer = StreamData.integer(-10_000..10_000)
    string = StreamData.string(:alphanumeric, min_length: 5, max_length: 10)

    StreamData.one_of([integer, string])
    |> Enum.take(number)
  end

  @spec gen_int_input(integer) :: integer()
  defp gen_int_input(number) do
    StreamData.integer(-number..number)
    |> Enum.take(number)
    |> Enum.random()
  end

  @spec sum_all_gen(list(integer)) :: integer
  defp sum_all_gen([num_one, num_two] = _list) do
    Enum.reduce(num_one..num_two, &(&1 + &2))
  end

  @spec sum_all_gen_v2(list(integer)) :: integer
  defp sum_all_gen_v2([num_one, num_two] = _list) do
    Enum.sum(num_one..num_two)
  end

  @spec sum_all_gen_v3(list(integer)) :: integer
  defp sum_all_gen_v3([0, 0]), do: 0

  defp sum_all_gen_v3([num_one, num_two] = _list) do
    for(x <- num_one..num_two, do: x)
    |> do_sum_all_v3()
  end

  defp do_sum_all_v3([]), do: 0
  defp do_sum_all_v3([h | t] = _list), do: h + do_sum_all_v3(t)

  defp diff_list_gen(list_one, list_two) do
    (list_one ++ list_two)
    |> Enum.frequencies()
    |> Enum.reduce([], fn {k, v}, acc ->
      if v === 1 do
        [k | acc]
      else
        acc
      end
    end)
  end
end

# alias Benchmark.IntermediateAlgo
# alias Benchee.Formatters.{HTML, Console}

# IntermediateAlgo.run("mutation", HTML)
# IntermediateAlgo.run("diff_list", Console)

# Available functions (uncomment above):
#   - diff_list
#   - sum_all
