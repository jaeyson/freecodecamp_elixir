defmodule FreecodecampElixir.BasicAlgo do
  @moduledoc """
  Documentation for Freecodecamp ([Basic Alogrithmic Scripting](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/#basic-algorithm-scripting)).
  """
  @moduledoc since: "0.1.0"

  @doc """
  The formula to convert from Celsius to Fahrenheit is the temperature in Celsius times `9/5`, plus `32`.

  Returns an integer.

  source: [Convert Celsius to Fahrenheit](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/convert-celsius-to-fahrenheit)

  ## Examples

      iex> BasicAlgo.convert_to_f(30)
      86

  """
  @doc since: "0.1.0"
  @spec convert_to_f(integer) :: integer
  def convert_to_f(celsius), do: div(celsius * 9, 5) + 32

  @doc """
  Reverses a string.

  source: [Reverse a String](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/reverse-a-string)

  ## Examples

      iex> BasicAlgo.reverse_string("hello")
      "olleh"

  """
  @doc since: "0.1.0"
  @spec reverse_string(String.t()) :: String.t()
  # defdelegate reverse_string(str), to: String, as: :reverse
  def reverse_string(""), do: ""

  def reverse_string(<<letter::utf8, rest::binary>> = _string),
    do: reverse_string(rest) <> <<letter>>

  @doc """
  Factorialize a number

  source: [Factorialize a Number](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/factorialize-a-number)

  ## Examples

      iex> BasicAlgo.factorialize(0)
      1

      iex> BasicAlgo.factorialize(5)
      120

  """
  @doc since: "0.1.0"
  @spec factorialize(integer) :: integer
  def factorialize(0), do: 1

  def factorialize(number) when is_integer(number) do
    1..number
    |> Stream.filter(&(&1 !== 0))
    |> Enum.to_list()
    |> do_factorialize()
  end

  @spec do_factorialize([integer]) :: integer
  defp do_factorialize(list) when list === [], do: 1
  defp do_factorialize([head | tail]), do: head * do_factorialize(tail)

  @doc """
  Return the length of the longest word in the provided sentence.

  Returns an integer.

  source: [Find the Longest Word in a String](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/find-the-longest-word-in-a-string)

  ## Examples

      iex> BasicAlgo.find_longest_word_length("")
      0

      iex> BasicAlgo.find_longest_word_length("May the force be with you")
      5

  """
  @doc since: "0.1.0"
  @spec find_longest_word_length(String.t()) :: integer
  def find_longest_word_length(""), do: 0

  def find_longest_word_length(string) when is_binary(string) do
    string
    |> String.splitter([" "])
    |> Enum.map(&String.length(&1))
    |> Enum.max()
  end

  @doc """
  Return an array consisting of the largest number from each provided sub-array. For simplicity, the provided array will contain exactly 4 sub-arrays.

  source: [Return Largest Numbers in Arrays](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/return-largest-numbers-in-arrays)

  ## Examples

      iex> BasicAlgo.largest_of_four([])
      []

      iex> BasicAlgo.largest_of_four([[17, 23, 25, 12], [25, 7, 34, 48], [4, -10, 18, 21], [-72, -3, -17, -10]])
      [25, 48, 21, -3]

  """
  @doc since: "0.1.0"
  @spec largest_of_four([integer]) :: [integer]
  def largest_of_four(list) do
    list
    |> Stream.filter(&(&1 !== []))
    |> Enum.to_list()
    |> do_largest_of_four()
  end

  @spec do_largest_of_four([integer]) :: [integer]
  defp do_largest_of_four([]), do: []

  defp do_largest_of_four([head | tail] = _list) do
    sorted_head = head |> Enum.sort(:desc) |> hd()

    [sorted_head | do_largest_of_four(tail)]
  end

  @doc """
  Return repeated string.

  source: [Repeat a String Repeat a String](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/repeat-a-string-repeat-a-string)

  ## Examples

      iex> BasicAlgo.repeat_string_num_times("abc", 2)
      "abcabc"

      iex> BasicAlgo.repeat_string_num_times("abc", 0)
      ""
      
      iex> BasicAlgo.repeat_string_num_times("", 100)
      ""
      
      iex> BasicAlgo.repeat_string_num_times("abc", -1)
      ""

  """
  @doc since: "0.1.0"
  @spec repeat_string_num_times(String.t(), integer) :: String.t()
  def repeat_string_num_times(_string, num) when num <= 0, do: ""
  def repeat_string_num_times("", _num), do: ""
  def repeat_string_num_times(string, 1), do: string

  def repeat_string_num_times(string, num) when num > 1 do
    string <> repeat_string_num_times(string, num - 1)
  end

  @doc """
  Returns true if the string in the first element of the array
  contains all of the letters of the string in the second
  element of the array.

  source: [Mutations](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/mutations)

  ## Examples

      iex> BasicAlgo.mutation(["hello", "Hey"])
      false

      iex> BasicAlgo.mutation(["hello", "neo"])
      false
      
      iex> BasicAlgo.mutation(["Noel", "Ole"])
      true

  """
  @doc since: "0.1.0"
  @spec mutation([String.t()]) :: boolean()
  def mutation(["", ""]), do: false
  def mutation(["", _source]), do: false
  def mutation([_target, ""]), do: false

  def mutation([target, source] = _list) do
    list =
      &(String.downcase(&1)
        |> String.split("", trim: true)
        |> Enum.uniq()
        |> Enum.sort())

    new_list = list.(target) |> Enum.filter(&(&1 in list.(source)))

    new_list == list.(source)
  end

  @doc """
  Truncate a string (first argument) if it is longer than
  the given maximum string length (second argument). Return
  the truncated string with a `...` ending.

  source: [Truncate a String](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/truncate-a-string)

  ## Examples

      iex> BasicAlgo.truncate_string("A-tisket a-tasket A green and yellow basket", 8)
      "A-tisket..."

      iex> BasicAlgo.truncate_string("Absolutely Longer", 2)
      "Ab..."
      
      iex> BasicAlgo.truncate_string("A-", 1)
      "A..."

      iex> BasicAlgo.truncate_string("A-tisket", -1)
      "..."

      iex> BasicAlgo.truncate_string("Hello", 50)
      "Hello..."

  """
  @doc since: "0.1.0"
  @spec truncate_string(String.t(), integer) :: String.t()
  def truncate_string(_words, len) when len <= 0, do: "..."
  def truncate_string("", _len), do: "..."

  def truncate_string(words, len) do
    case String.length(words) < len do
      true ->
        words <> "..."

      false ->
        words
        |> String.to_charlist()
        |> do_truncate_string(len)
        |> to_string()
        |> Kernel.<>("...")
    end
  end

  @spec do_truncate_string([char()], integer) :: list()
  defp do_truncate_string(_letter, 0), do: []

  defp do_truncate_string([head | tails] = _list, len),
    do: [[head] | do_truncate_string(tails, len - 1)]

  @doc """
  Return the lowest index at which a value (second argument) should be inserted into an array (first argument) once it has been **sorted**. The returned value should be a number.

  For example, `get_index_to_ins([1,2,3,4], 1.5)` should return 1 because it is greater than 1 (index 0), but less than 2 (index 1).

  Likewise, `get_index_to_ins([20,3,5], 19)` should return 2 because once the array has been sorted it will look like `[3,5,20]` and 19 is less than 20 (index 2) and greater than 5 (index 1).

  source: [Where do I Belong](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/where-do-i-belong)

  ## Examples

      iex> BasicAlgo.get_index_to_ins([1, 2, 3, 4], 1.5)
      1

      iex> BasicAlgo.get_index_to_ins([20, 3, 5], 19)
      2
      
      iex> BasicAlgo.get_index_to_ins([3, 10, 5], 3)
      0
      
  """
  @doc since: "0.1.0"
  @spec get_index_to_ins([integer], integer) :: integer
  def get_index_to_ins([], _value), do: 0

  def get_index_to_ins(list, value) do
    sorted_list = Enum.sort(list)

    result =
      for element <- sorted_list,
          element >= value,
          do:
            sorted_list
            |> Enum.find_index(&(&1 == round(element)))

    List.first(result) |> do_get_index_to_ins()
  end

  @spec do_get_index_to_ins(non_neg_integer | nil) :: non_neg_integer
  def do_get_index_to_ins(nil), do: 0
  def do_get_index_to_ins(result), do: result

  @doc """
  Check if a string (first argument, `string`) ends with the
  given target string (second argument, `target`).

  Returns a boolean.

  source: [Confirm the Ending](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/confirm-the-ending)

  ## Examples

      iex> BasicAlgo.confirm_ending("Bastian", "n")
      true

      iex> BasicAlgo.confirm_ending("Congratulation", "on")
      true
      
      iex> BasicAlgo.confirm_ending("Connor", "n")
      false
      
  """
  @doc since: "0.1.0"
  @spec confirm_ending(String.t(), String.t()) :: boolean()
  def confirm_ending(string, target)
      when byte_size(string) < byte_size(target) do
    false
  end

  def confirm_ending(string, target) do
    length = String.length(string) - String.length(target)
    <<_substr::binary-size(length), rest::binary>> = string
    rest === target
  end

  @doc """
  Returns the first element thats passes the `truth test` from a given function.

  source: [Finders Keepers](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/finders-keepers)

  ## Examples

      iex> BasicAlgo.find_element([1, 3, 5, 8, 9, 10], &Integer.mod(&1, 2) === 0)
      8

      iex> BasicAlgo.find_element([1, 3, 5, 9], &(Integer.mod(&1, 2) === 0))
      nil

      iex> BasicAlgo.find_element([], & &1 === 0)
      nil

  """
  @doc since: "0.1.0"
  @spec find_element(list(), function()) :: any()
  def find_element([], _fun), do: nil

  def find_element([head | _tail] = list, fun) do
    do_find_element(fun.(head), list, fun)
  end

  @spec do_find_element(boolean(), list(), function()) :: any()
  defp do_find_element(true, [head | _tail], _fun), do: head
  defp do_find_element(false, [_head | tail], fun), do: find_element(tail, fun)

  @doc """
  Check if a value is classified as a boolean primitive. Return true or false.

  source: [Boo who](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/boo-who)

  ## Examples

      iex> BasicAlgo.boo_who(true)
      true

      iex> BasicAlgo.boo_who(false)
      true

      iex> BasicAlgo.boo_who([])
      false

      iex> BasicAlgo.boo_who("a")
      false

  """
  @doc since: "0.1.0"
  @spec boo_who(any()) :: boolean()
  def boo_who(any) when is_boolean(any), do: true
  def boo_who(_not_boolean), do: false

  @doc """
  Capitalize each word in a sentence

  source: [Title Case a Sentence](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/title-case-a-sentence)

  ## Examples

      iex> BasicAlgo.title_case("I'm a little tea pot")
      "I'm A Little Tea Pot"

      iex> BasicAlgo.title_case("sHoRt AnD sToUt")
      "Short And Stout"

      iex> BasicAlgo.title_case("HERE IS MY HANDLE HERE IS MY SPOUT")
      "Here Is My Handle Here Is My Spout"

  """
  @doc since: "0.1.0"
  @spec title_case(String.t()) :: String.t()
  def title_case(""), do: ""

  def title_case(string) do
    do_title_case(~w(#{string}), "")
  end

  @spec do_title_case(String.t() | [], String.t()) :: String.t()
  defp do_title_case([], <<_::binary-size(1), string::binary>>), do: string

  defp do_title_case([head | tail] = _list, string) do
    <<first_letter::binary-size(1), rest::binary>> = head
    capitalized = ~s(#{string} #{String.upcase(first_letter)}#{String.downcase(rest)})
    do_title_case(tail, capitalized)
  end

  @doc """
  Inserts the 1st list in 2nd list at its index position (3rd param).
  Also an [SO link](https://stackoverflow.com/a/27420592/10250774) why doing
  binary search on linked list is slower. Used linear search instead.

  source: [Slice and Splice](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/slice-and-splice)

  ## Examples

      iex> BasicAlgo.franken_splice([1, 2, 3], [4, 5], 1)
      [4, 1, 2, 3, 5]

      iex> BasicAlgo.franken_splice([1, 2], ["a", "b"], 1)
      ["a", 1, 2, "b"]

      iex> BasicAlgo.franken_splice(["claw", "tentacle"], ["head", "shoulders", "knees", "toes"], 2)
      ["head", "shoulders", "claw", "tentacle", "knees", "toes"]

  """
  @doc since: "0.1.0"
  @spec franken_splice(Enumerable.t(), Enumerable.t(), integer) :: Enumerable.t()
  def franken_splice(list_a, list_b, el) when el >= 0 do
    do_franken_splice(el, list_a, [], list_b)
    |> List.flatten()
  end

  def franken_splice(list_a, list_b, el) when el < 0 do
    (length(list_b) + (el + 1))
    |> do_franken_splice(list_a, [], list_b)
    |> List.flatten()
  end

  @spec do_franken_splice(integer, list(), list(), list()) :: list()
  defp do_franken_splice(counter, list_a, list, list_b)
       when counter === 0,
       do: [list | [list_a | [list_b]]]

  defp do_franken_splice(counter, list_a, list, [h | t] = _list_b)
       when counter > 0,
       do: do_franken_splice(counter - 1, list_a, [list | [h]], t)

  defp do_franken_splice(_counter, list_a, list, list_b)
       when list_b === [],
       do: [list | [list_b | [list_a]]]

  defp do_franken_splice(_counter, list_a, list, list_b)
       when list === [],
       do: [list_a | [list | [list_b]]]

  @doc """
  Remove all falsy values from an array. Falsy values
  in JavaScript are `false, null, 0, "", undefined, and NaN`,
  only "", false, nil or 0 were implemented for simplicity
  reasons.

  source: [Falsy Bouncer](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/falsy-bouncer)


  ## Examples

      iex> BasicAlgo.bouncer([7, "ate", "", false, 9])
      [7, "ate", 9]

      iex> BasicAlgo.bouncer(["a", "b", "c"])
      ["a", "b", "c"]

      iex> BasicAlgo.bouncer([false, nil, 0, ""])
      []

      iex> BasicAlgo.bouncer([7, [], false, ""])
      [7, []]
  """
  @doc since: "0.1.0"
  @spec bouncer(list()) :: list()
  def bouncer(list), do: do_bouncer(list, [])

  @spec do_bouncer(list(), list()) :: list()
  defp do_bouncer(list, filtered_list) when list === [] do
    filtered_list
  end

  defp do_bouncer([head | tails] = _list, list) when head in ["", false, nil, 0] do
    do_bouncer(tails, list)
  end

  defp do_bouncer([head | tails] = _list, list) do
    do_bouncer(tails, List.flatten(list, [head]))
  end

  @doc """
  Splits a list (first argument) into groups the length
  of size (second argument) and returns them as a
  two-dimensional list.

  source: [Chunky Monkey](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/basic-algorithm-scripting/chunky-monkey)

  ## Examples

      iex> BasicAlgo.chunk_array_in_groups(["a", "b", "c", "d"], 2)
      [["a", "b"], ["c", "d"]]

      iex> BasicAlgo.chunk_array_in_groups([0, 1, 2, 3, 4, 5], 3)
      [[0, 1, 2], [3, 4, 5]]

      iex> BasicAlgo.chunk_array_in_groups([0, 1, 2, 3, 4, 5], 2)
      [[0, 1], [2, 3], [4, 5]]

  """
  @doc since: "0.1.0"
  @spec chunk_array_in_groups(list(), integer) :: [list()]
  def chunk_array_in_groups([], _size), do: []
  def chunk_array_in_groups(list, size) when size < 1, do: list

  def chunk_array_in_groups(list, size) do
    do_chunk_array_in_groups([], [], list, size, 0)
  end

  @spec do_chunk_array_in_groups(list(), list(), list(), integer, integer) :: list()
  defp do_chunk_array_in_groups(list_a, list_b, [], _, _) do
    list_a ++ [list_b]
  end

  defp do_chunk_array_in_groups(list_a, list_b, [h | t] = _, size, counter)
       when counter < size do
    do_chunk_array_in_groups(list_a, list_b ++ [h], t, size, counter + 1)
  end

  defp do_chunk_array_in_groups(list_a, list_b, [h | t] = _, size, counter)
       when counter === size do
    do_chunk_array_in_groups(list_a ++ [list_b], [h], t, size, 1)
  end
end
