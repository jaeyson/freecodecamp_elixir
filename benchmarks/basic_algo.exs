defmodule Benchmark.BasicAlgo do
  alias Freecodecamp.BasicAlgo

  @spec run(String.t(), module(), any()) :: module()
  def run(function_name, formatter, args \\ nil),
    do: __MODULE__ |> apply(String.to_atom(function_name), [formatter, args])

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

  @spec mutation(module(), any()) :: module()
  def mutation(formatter, _args) do
    generic_benchee(
      %{
        "mutation: Enum.filter" => fn {string1, string2} ->
          mutation_gen([string1, string2], :enum_filter)
        end,
        "mutation: List comprehension" => fn {string1, string2} ->
          mutation_gen([string1, string2], :list_comprehension)
        end
      },
      formatter,
      fn _ ->
        {
          gen_string_input(),
          gen_string_input()
        }
      end
    )
  end

  @spec truncate_string(module(), any()) :: module()
  def truncate_string(formatter, _args) do
    generic_benchee(
      %{
        "BasicAlgo.truncate_string" => fn {string, pos} ->
          BasicAlgo.truncate_string(string, pos)
        end,
        "Charlist and Enum.split" => fn {string, pos} ->
          truncate_string_gen(string, pos, :enum_split)
        end,
        "String.split_at" => fn {string, pos} ->
          truncate_string_gen(string, pos, :string_split_at)
        end
      },
      formatter,
      fn _ ->
        {
          gen_string_input(),
          gen_int_input(10_000)
        }
      end
    )
  end

  @spec get_index_to_ins(module(), any()) :: module()
  def get_index_to_ins(formatter, _args) do
    generic_benchee(
      %{
        "get_index_to_ins: List comprehension" => fn {list_int, value} ->
          BasicAlgo.get_index_to_ins(list_int, value)
        end,
        "get_index_to_ins: Enum.filter" => fn {list_int, value} ->
          get_index_to_ins_gen(list_int, value)
        end
      },
      formatter,
      fn _ ->
        {
          gen_list_int_input(10_000),
          gen_int_input(10_000)
        }
      end
    )
  end

  @spec factorialize(module(), any()) :: module()
  def factorialize(formatter, _args) do
    generic_benchee(
      %{
        "factorialize: Enum.filter and tco function" => &BasicAlgo.factorialize/1,
        "factorialize: Stream.filter and reduce" => &factorialize_gen/1
      },
      formatter,
      fn _ -> gen_int_input(10_000) end
    )
  end

  @spec reverse_string(module(), any()) :: module()
  def reverse_string(formatter, _args) do
    generic_benchee(
      %{
        "reverse_string: Pattern matching" => &BasicAlgo.reverse_string/1,
        "reverse_string: String.reverse" => &String.reverse/1
      },
      formatter,
      fn _ -> gen_string_input() end
    )
  end

  @spec reverse_string(module(), any()) :: module()
  def find_longest_word_length(formatter, _args) do
    generic_benchee(
      %{
        "find_longest_word_length: Enum.max_by" => &BasicAlgo.find_longest_word_length/1,
        "find_longest_word_length: Enum.map & Enum.max" => &find_longest_word_length_gen/1
      },
      formatter,
      fn _ -> gen_string_input() end
    )
  end

  @spec largest_of_four(module(), any()) :: module()
  def largest_of_four(formatter, _args) do
    list_int =
      -10_000..10_000
      |> StreamData.integer()
      |> StreamData.list_of(length: 4)
      |> Enum.take(4)

    generic_benchee(
      %{
        "largest_of_four: Enum.max" => &BasicAlgo.largest_of_four/1,
        "largest_of_four: Tail Call" => &largest_of_four_gen/1
      },
      formatter,
      fn _ -> list_int end
    )
  end

  @spec confirm_ending(module(), any()) :: module()
  def confirm_ending(formatter, _args) do
    generic_benchee(
      %{
        "confirm_ending: String.ends_with?" => fn {str_one, str_two} ->
          BasicAlgo.confirm_ending(str_one, str_two)
        end,
        "confirm_ending: pattern match" => fn {str_one, str_two} ->
          confirm_ending_gen(str_one, str_two)
        end
      },
      formatter,
      fn _ ->
        {
          gen_string_input(),
          gen_string_input()
        }
      end
    )
  end

  ##################################################
  ### Below are helpers for the main functions above
  ##################################################

  @spec gen_list_int_input(integer) :: list(integer)
  defp gen_list_int_input(number) do
    StreamData.integer(-number..number)
    |> StreamData.list_of()
    |> Enum.take(number)
    |> Enum.random()
  end

  @spec gen_int_input(integer) :: integer()
  defp gen_int_input(number) do
    StreamData.integer(-number..number)
    |> Enum.take(number)
    |> Enum.random()
  end

  @spec gen_string_input :: String.t()
  defp gen_string_input do
    :alphanumeric
    |> StreamData.string(min_length: 3)
    |> Enum.take(30)
    |> Enum.random()
  end

  @spec mutation_gen(list(String.t()), atom()) :: boolean()
  defp mutation_gen([target, source] = _list, :enum_filter) do
    enum_filter =
      mutation_list(target)
      |> Enum.filter(&(&1 in mutation_list(source)))

    enum_filter === mutation_list(source)
  end

  defp mutation_gen([target, source] = _list, :list_comprehension) do
    list_comprehension =
      for el <- mutation_list(target),
          el in mutation_list(source),
          do: el

    list_comprehension === mutation_list(source)
  end

  @spec mutation_list(String.t()) :: list(String.t())
  defp mutation_list(string) do
    String.downcase(string)
    |> String.split("", trim: true)
    |> Enum.uniq()
    |> Enum.sort()
  end

  @spec truncate_string_gen(String.t(), integer(), atom()) :: String.t()
  defp truncate_string_gen(_words, len, _version) when len <= 0, do: "..."

  defp truncate_string_gen(words, len, :enum_split) do
    {trimmed_word, _} = String.to_charlist(words) |> Enum.split(len)
    to_string(trimmed_word) <> "..."
  end

  defp truncate_string_gen(words, len, :string_split_at) do
    {trimmed_word, _} = String.split_at(words, len)
    trimmed_word <> "..."
  end

  @spec get_index_to_ins_gen(list(integer), integer) :: integer
  defp get_index_to_ins_gen([], _value), do: 0

  defp get_index_to_ins_gen(list, value) do
    sorted_list = Enum.sort(list)

    sorted_list
    |> Enum.filter(&(&1 >= round(value)))
    |> do_get_index_to_ins(sorted_list)
  end

  defp do_get_index_to_ins([], _list), do: 0

  defp do_get_index_to_ins(result, list) do
    Enum.find_index(list, &(&1 == List.first(result)))
  end

  @spec factorialize_gen(integer) :: integer
  defp factorialize_gen(number) do
    1..number
    |> Stream.filter(&(&1 !== 0))
    |> Enum.reduce(1, &(&1 * &2))
  end

  @spec find_longest_word_length_gen(integer) :: integer
  defp find_longest_word_length_gen(""), do: 0

  defp find_longest_word_length_gen(string) do
    string
    |> String.splitter([" "])
    |> Enum.map(&String.length(&1))
    |> Enum.max()
  end

  @spec largest_of_four_gen(list(list(integer))) :: list(integer)
  defp largest_of_four_gen(list) do
    list
    |> Stream.filter(&(&1 !== []))
    |> Stream.map(&Enum.max/1)
    |> Enum.to_list()
  end

  @spec confirm_ending_gen(String.t(), String.t()) :: boolean()
  def confirm_ending_gen(string, target) do
    String.ends_with?(string, target)
  end
end

alias Benchmark.BasicAlgo
alias Benchee.Formatters.{HTML, Console}

# BasicAlgo.run("mutation", HTML)
BasicAlgo.run("confirm_ending", Console)

# Available functions (uncomment above):
#   - mutation
#   - truncate_string
#   - get_index_to_ins
#   - factorialize
#   - reverse_string
#   - find_longest_word_length
#   - largest_of_four
#   - confirm_ending
