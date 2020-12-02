defmodule BasicAlgoTest do
  use ExUnit.Case, async: true
  use ExUnitProperties, async: true

  alias Freecodecamp.BasicAlgo
  doctest Freecodecamp.BasicAlgo

  describe "Convert Celsius to Fahrenheit:" do
    property "takes a random integer and converts it" do
      check all(number <- integer()) do
        test_number =
          (number * 9)
          |> div(5)
          |> Kernel.+(32)

        origin_number = ((test_number - 32) * 5 / 9) |> round()

        assert BasicAlgo.convert_to_f(number) == test_number
        assert number == origin_number
      end
    end
  end

  describe "Reverse a string:" do
    property "takes a random string and reverse it twice" do
      check all(str <- string(:printable)) do
        test_string =
          str
          |> String.split("", trim: true)
          |> Enum.reverse()
          |> Enum.join("")

        assert BasicAlgo.reverse_string(str) == test_string
      end
    end
  end

  describe "Factorialize a number:" do
    test "!5 == 120",
      do: assert(BasicAlgo.factorialize(5) == 120)

    test "!20 == 2_432_902_008_176_640_000",
      do: assert(BasicAlgo.factorialize(20) == 2_432_902_008_176_640_000)

    test "!0 == 1",
      do: assert(BasicAlgo.factorialize(0) == 1)
  end

  describe "Find the longest word in a string:" do
    test "jumped = 6",
      do:
        assert(
          BasicAlgo.find_longest_wordlength("The quick brown fox jumped over the lazy dog") == 6
        )

    test "force = 5",
      do: assert(BasicAlgo.find_longest_wordlength("May the force be with you") == 5)
  end

  describe "Return largest numbers in lists:" do
    test "returns [27, 5, 39, 1001]",
      do:
        assert(
          BasicAlgo.largest_of_four([
            [13, 27, 18, 26],
            [4, 5, 1, 3],
            [32, 35, 37, 39],
            [1000, 1001, 857, 1]
          ]) == [27, 5, 39, 1001]
        )

    test "returns [9, 35, 97, 1000000]",
      do:
        assert(
          BasicAlgo.largest_of_four([
            [4, 9, 1, 3],
            [13, 35, 18, 26],
            [32, 35, 97, 39],
            [1_000_000, 1001, 857, 1]
          ]) == [9, 35, 97, 1_000_000]
        )

    test "returns [25, 48, 21, -3]",
      do:
        assert(
          BasicAlgo.largest_of_four([
            [17, 23, 25, 12],
            [25, 7, 34, 48],
            [4, -10, 18, 21],
            [-72, -3, -17, -10]
          ]) == [25, 48, 21, -3]
        )
  end

  describe "Repeat a string:" do
    property "Repeats a string for random amount of times" do
      check all(
              str <- string(:printable),
              pos_int <- positive_integer(),
              neg_int <- integer(-1..-10_000)
            ) do
        assert BasicAlgo.repeat_string_num_times(str, pos_int) ==
                 String.duplicate(str, pos_int)

        assert BasicAlgo.repeat_string_num_times(str, neg_int) == ""

        assert BasicAlgo.repeat_string_num_times(str, 0) == ""
      end
    end
  end

  describe "Mutations" do
    property "Test different inputs" do
      check all(
              str1 <- string(:alphanumeric, min_length: 3),
              str2 <- string(:alphanumeric, min_length: 3)
            ) do
        sort_list =
          &(String.downcase(&1)
            |> String.split("", trim: true)
            |> Enum.uniq()
            |> Enum.sort())

        sort_first_string =
          for letter <- sort_list.(str1),
              letter in sort_list.(str2),
              do: letter

        test_boolean = sort_first_string === sort_list.(str2)

        assert BasicAlgo.mutation(["", ""]) === false
        assert BasicAlgo.mutation([str1, ""]) === false
        assert BasicAlgo.mutation(["", str2]) === false
        assert BasicAlgo.mutation([str1, str2]) === test_boolean
      end
    end
  end

  describe "Truncate string and appends ellipses" do
    property "random strings and truncate with ellipses" do
      check all(
              string <- string(:alphanumeric, min_length: 3),
              pos_int <- positive_integer(),
              neg_int <- integer(-1..-10_000)
            ) do
        test_truncate = fn words, len ->
          {trimmed_word, _} = String.split_at(words, len)
          trimmed_word <> "..."
        end

        assert BasicAlgo.truncate_string("", pos_int) === "..."
        assert BasicAlgo.truncate_string("", neg_int) === "..."
        assert BasicAlgo.truncate_string(string, neg_int) === "..."
        assert BasicAlgo.truncate_string(string, 0) === "..."
        assert BasicAlgo.truncate_string(string, pos_int) === test_truncate.(string, pos_int)
      end
    end
  end

  describe "Basic Algorithm Scripting: Where do I Belong" do
    property "takes a list of random integer and returns the lowest index from a value" do
      check all(
              list_of_int <- list_of(integer()),
              value <- integer()
            ) do
        test_helper = fn result, sorted_list ->
          case result === [] do
            true ->
              0

            false ->
              Enum.find_index(sorted_list, &(&1 == List.first(result)))
          end
        end

        test_main = fn list_of_int, value ->
          sorted_list = Enum.sort(list_of_int)

          sorted_list
          |> Enum.filter(&(&1 >= round(value)))
          |> test_helper.(sorted_list)
        end

        assert BasicAlgo.get_index_to_ins([], 0) == 0
        assert test_main.([], 0) == 0
        assert BasicAlgo.get_index_to_ins(list_of_int, value) == test_main.(list_of_int, value)
      end
    end
  end
end
