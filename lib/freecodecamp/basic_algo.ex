defmodule Freecodecamp.BasicAlgo do
  # @type word() :: String.t()

  @moduledoc """
  Documentation for Freecodecamp (Basic Alogrithmic Scripting).
  """

  @doc """
  Convert Celsius to Fahrenheit

  ## Examples

      iex> BasicAlgo.convert_to_f(30)
      86

  """
  @spec convert_to_f(integer) :: integer
  def convert_to_f(celsius \\ 0) when is_integer(celsius),
    do: div(celsius * 9, 5) + 32

  @doc """
  Reverses a string

  ## Examples

      iex> BasicAlgo.reverse_string("hello")
      "olleh"

  """
  @spec reverse_string(String.t()) :: String.t()
  # defdelegate reverse_string(str), to: String, as: :reverse
  def reverse_string(""), do: ""

  def reverse_string(<<letter::utf8, rest::binary>> = _string),
    do: reverse_string(rest) <> <<letter>>

  @doc """
  Factorialize a number

  ## Examples

      iex> BasicAlgo.factorialize(0)
      1

      iex> BasicAlgo.factorialize(5)
      120

  """
  @spec factorialize(integer) :: integer
  def factorialize(0), do: 1

  def factorialize(number) when is_integer(number) do
    1..number
    |> Stream.filter(&(&1 !== 0))
    |> Enum.to_list()
    |> do_factorialize()
  end

  defp do_factorialize(list) when list === [], do: 1
  defp do_factorialize([head | tail]), do: head * do_factorialize(tail)

  @doc """
  Find the longest word and returns the length of it

  ## Examples

      iex> BasicAlgo.find_longest_word_length("")
      0

      iex> BasicAlgo.find_longest_word_length("May the force be with you")
      5

  """
  @spec find_longest_word_length(String.t()) :: integer
  def find_longest_word_length(""), do: 0

  def find_longest_word_length(string) when is_binary(string) do
    string
    |> String.splitter([" "])
    |> Enum.map(&String.length(&1))
    |> Enum.max()
  end

  @doc """
  Return largest numbers in lists

  ## Examples

      iex> BasicAlgo.largest_of_four([])
      []

      iex> BasicAlgo.largest_of_four([[17, 23, 25, 12], [25, 7, 34, 48], [4, -10, 18, 21], [-72, -3, -17, -10]])
      [25, 48, 21, -3]

  """
  @spec largest_of_four(list(integer)) :: integer
  def largest_of_four(list) do
    list
    |> Stream.filter(&(&1 !== []))
    |> Enum.to_list()
    |> do_largest_of_four()
  end

  defp do_largest_of_four([]), do: []

  defp do_largest_of_four([head | tail] = _list) do
    sorted_head = head |> Enum.sort(:desc) |> hd()

    [sorted_head | do_largest_of_four(tail)]
  end

  @doc """
  Return repeated string

  ## Examples

      iex> BasicAlgo.repeat_string_num_times("abc", 2)
      "abcabc"

      iex> BasicAlgo.repeat_string_num_times("abc", 0)
      ""
      
      iex> BasicAlgo.repeat_string_num_times("abc", -1)
      ""

  """
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

  ## Examples

      iex> BasicAlgo.mutation(["hello", "Hey"])
      false

      iex> BasicAlgo.mutation(["hello", "neo"])
      false
      
      iex> BasicAlgo.mutation(["Noel", "Ole"])
      true

  """
  @spec mutation(list(String.t())) :: boolean()
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

  defp do_truncate_string(_letter, 0), do: []

  defp do_truncate_string([head | tails] = _list, len),
    do: [[head] | do_truncate_string(tails, len - 1)]

  @doc """
  Return the lowest index at which a value (second argument) should be inserted into an array (first argument) once it has been **sorted**. The returned value should be a number.

  For example, `get_index_to_ins([1,2,3,4], 1.5)` should return 1 because it is greater than 1 (index 0), but less than 2 (index 1).

  Likewise, `get_index_to_ins([20,3,5], 19)` should return 2 because once the array has been sorted it will look like `[3,5,20]` and 19 is less than 20 (index 2) and greater than 5 (index 1).

  ## Examples

      iex> BasicAlgo.get_index_to_ins([1, 2, 3, 4], 1.5)
      1

      iex> BasicAlgo.get_index_to_ins([20, 3, 5], 19)
      2
      
      iex> BasicAlgo.get_index_to_ins([3, 10, 5], 3)
      0
      
  """
  @spec get_index_to_ins(list(integer), integer) :: integer
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

  def do_get_index_to_ins(nil), do: 0
  def do_get_index_to_ins(result), do: result

  @doc """
  Check if a string (first argument, `string`) ends with the
  given target string (second argument, `target`).

  ## Examples

      iex> BasicAlgo.confirm_ending("Bastian", "n")
      true

      iex> BasicAlgo.confirm_ending("Congratulation", "on")
      true
      
      iex> BasicAlgo.confirm_ending("Connor", "n")
      false
      
  """
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

  ## Examples

      iex> BasicAlgo.find_element([1, 3, 5, 8, 9, 10], &Integer.mod(&1, 2) === 0)
      8

      iex> BasicAlgo.find_element([1, 3, 5, 9], &(Integer.mod(&1, 2) === 0))
      nil

      iex> BasicAlgo.find_element([], & &1 === 0)
      nil

  """
  @spec find_element(Enumerable.t(), function()) :: any()
  def find_element([], _fun), do: nil

  def find_element([head | _tail] = list, fun) do
    do_find_element(fun.(head), list, fun)
  end

  defp do_find_element(true, [head | _tail], _fun), do: head
  defp do_find_element(false, [_head | tail], fun), do: find_element(tail, fun)

  @doc """
  Check if a value is classified as a boolean primitive. Return true or false.

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
  @spec boo_who(any()) :: boolean()
  def boo_who(any) when is_boolean(any), do: true
  def boo_who(_not_boolean), do: false

  @doc """
  Capitalize each word in a sentence

  ## Examples

      iex> BasicAlgo.title_case("I'm a little tea pot")
      "I'm A Little Tea Pot"

      iex> BasicAlgo.title_case("sHoRt AnD sToUt")
      "Short And Stout"

      iex> BasicAlgo.title_case("HERE IS MY HANDLE HERE IS MY SPOUT")
      "Here Is My Handle Here Is My Spout"

  """
  @spec title_case(String.t()) :: String.t()
  def title_case(""), do: ""

  def title_case(string) do
    do_title_case(~w(#{string}), "")

    # ~w(#{string})
    # |> Enum.map(&String.downcase(&1))
    # |> Enum.map(&String.capitalize(&1))
    # |> Enum.join(" ")
  end

  defp do_title_case([], <<_::binary-size(1), string::binary>>), do: string

  defp do_title_case([head | tail] = _list, string) do
    <<first_letter::binary-size(1), rest::binary>> = head
    capitalized = ~s(#{string} #{String.upcase(first_letter)}#{String.downcase(rest)})
    do_title_case(tail, capitalized)
  end
end
