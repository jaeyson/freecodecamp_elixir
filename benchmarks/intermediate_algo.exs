defmodule Benchmark.IntermediateAlgo do
  alias Freecodecamp.IntermediateAlgo

  @spec run(String.t(), module(), any()) :: module()
  def run(function_name, formatter, args \\ nil),
    do: __MODULE__ |> apply(String.to_atom(function_name), [formatter, args])

  # set config for benchmark here
  defp generic_benchee(jobs, formatter, before_each_function) do
    Benchee.run(
      jobs,
      before_each: before_each_function,
      time: 5,
      memory_time: 2,
      warmup: 4,
      formatters: [formatter]
    )
  end

  @spec mutation(module(), any()) :: module()
  def sum_all(formatter, _args) do
    generic_benchee(
      %{
        "Enum.to_list" => fn {int1, int2} ->
          Enum.to_list(int1..int2)
        end,
        "list comprehension" => fn {int1, int2} ->
          for int <- int1..int2, do: int
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

  @spec find_element(module(), any()) :: module()
  def find_element(formatter, _args) do
    generic_benchee(
      %{
        "find_element: Enum.find" => fn list ->
          Enum.find(list, fn num -> Integer.mod(num, 2) === 0 end)
        end,
        "find_element: BasicAlgo.find_element" => fn list ->
          BasicAlgo.find_element(list, fn num -> Integer.mod(num, 2) === 0 end)
        end,
        "find_element: case expression" => fn list ->
          find_element_gen(list, fn num -> Integer.mod(num, 2) === 0 end)
        end
      },
      formatter,
      fn _ -> gen_list_int_input(1_000) end
    )
  end

  @spec title_case(module(), any()) :: module()
  def title_case(formatter, _args) do
    generic_benchee(
      %{
        "title_case: BasicAlgo.title_case" => fn string ->
          BasicAlgo.title_case(string)
        end,
        "title_case: sigil with map" => fn string ->
          title_case_gen(string)
        end
      },
      formatter,
      fn _ -> gen_sentence() end
    )
  end

  @spec franken_splice(module(), any()) :: module()
  def franken_splice(formatter, _args) do
    generic_benchee(
      %{
        "franken_splice: BasicAlgo.franken_splice" => fn {listA, listB, int} ->
          BasicAlgo.franken_splice(listA, listB, int)
        end,
        "franken_splice: List.insert_at" => fn {listA, listB, int} ->
          franken_splice_gen_v1(listA, listB, int)
        end,
        "franken_splice: Enum.split" => fn {listA, listB, int} ->
          franken_splice_gen_v2(listA, listB, int)
        end
      },
      formatter,
      fn _ ->
        {
          gen_list_int_input(10_000),
          gen_list_int_input(10_000),
          gen_int_input(10_000)
        }
      end
    )
  end

  @spec chunk_array_in_groups(module(), any()) :: module()
  def chunk_array_in_groups(formatter, _args) do
    generic_benchee(
      %{
        "chunk_array_in_groups: BasicAlgo.chunk_array_in_groups" => fn {list, size} ->
          BasicAlgo.chunk_array_in_groups(list, size)
        end,
        "chunk_array_in_groups: Enum.chunk_every" => fn {list, size} ->
          chunk_array_in_groups_gen(list, size)
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

  @spec gen_sentence :: String.t()
  defp gen_sentence do
    :alphanumeric
    |> StreamData.string(min_length: 3)
    |> Enum.take(20)
    |> Enum.join(" ")
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
  defp confirm_ending_gen(string, target) do
    String.ends_with?(string, target)
  end

  @spec find_element_gen(Enumerable.t(), function()) :: any()
  defp find_element_gen([], _fun), do: nil

  defp find_element_gen([head | tail] = _list, fun) do
    case fun.(head) do
      true ->
        head

      false ->
        find_element_gen(tail, fun)
    end
  end

  @spec title_case_gen(String.t()) :: String.t()
  def title_case_gen(string) do
    ~w(#{string})
    |> Enum.map(&String.downcase(&1))
    |> Enum.map(&String.capitalize(&1))
    |> Enum.join(" ")
  end

  @spec franken_splice_gen_v1(Enumerable.t(), Enumerable.t(), integer) :: Enumerable.t()
  def franken_splice_gen_v1([], [], _el), do: []

  def franken_splice_gen_v1(list_one, list_two, el) do
    List.insert_at(list_two, el, list_one) |> List.flatten()
  end

  @spec franken_splice_gen_v2(Enumerable.t(), Enumerable.t(), integer) :: Enumerable.t()
  def franken_splice_gen_v2(list_one, list_two, -1) do
    {head, tails} = Enum.split(list_two, length(list_two))
    [head | [list_one | [tails]]] |> :lists.flatten()
  end

  def franken_splice_gen_v2(list_one, list_two, el) when el < -1 do
    {head, tails} = Enum.split(list_two, el + 1)

    do_franken_splice(list_one, head, tails)
    |> :lists.flatten()
  end

  def franken_splice_gen_v2(list_one, list_two, el) do
    {head, tails} = Enum.split(list_two, el)

    do_franken_splice(list_one, head, tails)
    |> :lists.flatten()
  end

  defp do_franken_splice(list_one, head, tails) do
    [head | [list_one | [tails]]]
  end

  @spec chunk_array_in_groups_gen(Enumerable.t(), integer) :: list(Enumerable.t())
  def chunk_array_in_groups_gen([], _size), do: []
  def chunk_array_in_groups_gen(list, size) when size < 1, do: list

  def chunk_array_in_groups_gen(list, size) do
    Enum.chunk_every(list, size)
  end
end

alias Benchmark.IntermediateAlgo
alias Benchee.Formatters.{HTML, Console}

# IntermediateAlgo.run("mutation", HTML)
IntermediateAlgo.run("sum_all", Console)

# Available functions (uncomment above):
#   - sum_all
