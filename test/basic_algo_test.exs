defmodule BasicAlgoTest do
  use ExUnit.Case, async: true
  use ExUnitProperties, async: true

  alias Freecodecamp.BasicAlgo
  doctest Freecodecamp.BasicAlgo

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Convert Celsius to Fahrenheit" do
    property "takes a random integer and converts it to Fahrenheit" do
      check all(number <- integer()) do
        test_function =
          (number * 9)
          |> div(5)
          |> Kernel.+(32)

        origin_number = ((test_function - 32) * 5 / 9) |> round()

        assert BasicAlgo.convert_to_f(number) == test_function
        assert number == origin_number
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Reverse a String" do
    property "takes a random string and reverses it" do
      check all(string <- string(:alphanumeric, min_length: 3, max_length: 1_000)) do
        assert BasicAlgo.reverse_string(string) == String.reverse(string)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Factorialize a Number" do
    property "takes a random number and factorialize" do
      check all(number <- integer(-1_000..1_000)) do
        test_function = fn input ->
          1..input
          |> Stream.filter(&(&1 !== 0))
          |> Enum.reduce(1, &(&1 * &2))
        end

        assert BasicAlgo.factorialize(0) === 1
        assert test_function.(0) === 1
        assert BasicAlgo.factorialize(number) === test_function.(number)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Find the Longest Word in a String" do
    property "takes random strings then returns integer" do
      check all(string <- string(:alphanumeric, min_length: 3, max_length: 1_000)) do
        test_function = fn string ->
          case string do
            "" ->
              0

            _ ->
              string
              |> String.split()
              |> Enum.max_by(&String.length(&1))
              |> String.length()
          end
        end

        assert BasicAlgo.find_longest_word_length("") == 0
        assert test_function.("") == 0
        assert BasicAlgo.find_longest_word_length(string) == test_function.(string)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Return Largest Numbers in Lists" do
    property "takes a list of random no.s & return largest in each of these" do
      check all(
              random_input_one <- integer(-10_000..10_000) |> list_of(length: 4),
              random_input_two <- integer(-10_000..10_000) |> list_of(length: 4),
              random_input_three <- integer(-10_000..10_000) |> list_of(length: 4),
              random_input_four <- integer(-10_000..10_000) |> list_of(length: 4)
            ) do
        list_of_int = [
          random_input_one,
          random_input_two,
          random_input_three,
          random_input_four
        ]

        test_function = fn list ->
          list
          |> Stream.filter(&(&1 !== []))
          |> Stream.map(&Enum.max/1)
          |> Enum.to_list()
        end

        assert BasicAlgo.largest_of_four(list_of_int) === test_function.(list_of_int)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Repeat a String Repeat a String" do
    property "Repeats a string for random amount of times" do
      check all(
              str <- string(:alphanumeric, min_length: 3, max_length: 1_000),
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

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Mutations" do
    property "takes a list of two random strings and returns boolean" do
      check all(
              str1 <- string(:alphanumeric, min_length: 3, max_length: 1_000),
              str2 <- string(:alphanumeric, min_length: 3, max_length: 1_000)
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

        test_function = sort_first_string === sort_list.(str2)

        assert BasicAlgo.mutation(["", ""]) === false
        assert BasicAlgo.mutation([str1, ""]) === false
        assert BasicAlgo.mutation(["", str2]) === false
        assert BasicAlgo.mutation([str1, str2]) === test_function
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Truncate a String" do
    property "random strings and truncate with ellipses" do
      check all(
              string <- string(:alphanumeric, min_length: 3, max_length: 1_000),
              pos_int <- positive_integer(),
              neg_int <- integer(-1..-10_000)
            ) do
        test_function = fn words, len ->
          {trimmed_word, _} = String.split_at(words, len)
          trimmed_word <> "..."
        end

        assert BasicAlgo.truncate_string("", pos_int) === "..."
        assert BasicAlgo.truncate_string("", neg_int) === "..."
        assert BasicAlgo.truncate_string(string, neg_int) === "..."
        assert BasicAlgo.truncate_string(string, 0) === "..."
        assert BasicAlgo.truncate_string(string, pos_int) === test_function.(string, pos_int)
      end
    end
  end

  @tag :basic_algo
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

        test_function = fn list_of_int, value ->
          sorted_list = Enum.sort(list_of_int)

          sorted_list
          |> Enum.filter(&(&1 >= round(value)))
          |> test_helper.(sorted_list)
        end

        assert BasicAlgo.get_index_to_ins([], 0) == 0
        assert test_function.([], 0) == 0

        assert BasicAlgo.get_index_to_ins(list_of_int, value) ==
                 test_function.(list_of_int, value)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Confirm the Ending" do
    property "takes 2 words then returns boolean, comparion with string ends with target " do
      check all(
              string <- string(:alphanumeric, min_length: 3, max_length: 1_000),
              target <- string(:alphanumeric, min_length: 3, max_length: 1_000)
            ) do
        test_function = fn str, tar ->
          String.ends_with?(str, tar)
        end

        assert BasicAlgo.confirm_ending("", "") === true
        assert BasicAlgo.confirm_ending("", "ion") === false
        assert BasicAlgo.confirm_ending("Bastian", "") === true
        assert BasicAlgo.confirm_ending("Bastian", "n") === true
        assert BasicAlgo.confirm_ending("Connor", "n") === false

        assert BasicAlgo.confirm_ending("Abstraction", "action") === true
        assert BasicAlgo.confirm_ending(string, target) === test_function.(string, target)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Finders Keepers" do
    property "looks thru a list then returns first element that passes" do
      check all(list <- list_of(integer())) do
        test_function = fn list, fun ->
          Enum.find(list, fun)
        end

        assert BasicAlgo.find_element([1, 3, 5, 8, 9, 10], &(Integer.mod(&1, 2) === 0)) === 8
        assert test_function.([1, 3, 5, 8, 9, 10], &(Integer.mod(&1, 2) === 0)) === 8

        assert BasicAlgo.find_element([1, 3, 5, 9], &(Integer.mod(&1, 2) === 0)) === nil
        assert test_function.([1, 3, 5, 9], &(Integer.mod(&1, 2) === 0)) === nil

        assert BasicAlgo.find_element(list, &(Integer.mod(&1, 2) === 0)) ===
                 test_function.(list, &(Integer.mod(&1, 2) === 0))
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Boo Who" do
    test "takes an input and returns if it's type of boolean" do
      assert BasicAlgo.boo_who(true) === true
      assert BasicAlgo.boo_who(false) === true
      assert BasicAlgo.boo_who([1, 2, 3]) === false
      assert BasicAlgo.boo_who(%{a: 1}) === false
      assert BasicAlgo.boo_who(1) === false
      assert BasicAlgo.boo_who(nil) === false
      assert BasicAlgo.boo_who("true") === false
      assert BasicAlgo.boo_who("false") === false
      assert BasicAlgo.boo_who("hello") === false
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Title Case A Sentence" do
    property "Capitalize each word" do
      check all(string <- list_of(string(:alphanumeric, min_length: 3), length: 50)) do
        test_string = Enum.join(string, " ")

        test_function = fn str ->
          str
          |> String.split(" ", trim: true)
          |> Enum.map(&String.downcase(&1))
          |> Enum.map(&String.capitalize(&1))
          |> Enum.join(" ")
        end

        assert BasicAlgo.title_case("") === test_function.("")
        assert BasicAlgo.title_case(test_string) === test_function.(test_string)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Slice and Splice" do
    property "inserts the first list at certain location in second list" do
      check all(
              list_A <- list_of(integer()),
              list_B <- list_of(integer()),
              position <- integer()
            ) do
        test_function = fn list_one, list_two, el ->
          case Enum.empty?(list_one) && Enum.empty?(list_two) do
            true ->
              []

            false ->
              List.insert_at(list_two, el, list_one) |> List.flatten()
          end
        end

        assert BasicAlgo.franken_splice(list_A, list_B, position) ===
                 test_function.(list_A, list_B, position)

        assert BasicAlgo.franken_splice(list_A, list_B, position) ===
                 test_function.(list_A, list_B, position)

        assert BasicAlgo.franken_splice(list_A, list_B, position) ===
                 test_function.(list_A, list_B, position)
      end
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Falsy Bouncer" do
    test "remove falsy (JS reference) values from list" do
      assert BasicAlgo.bouncer([7, "ate", "", false, 9]) === [7, "ate", 9]
      assert BasicAlgo.bouncer(["a", "b", "c"]) === ["a", "b", "c"]
      assert BasicAlgo.bouncer([false, nil, 0, ""]) === []
      assert BasicAlgo.bouncer([7, [], false, ""]) === [7, []]
    end
  end

  @tag :basic_algo
  describe "Basic Algorithm Scripting: Chunky Monkey" do
    property "splits a list and returns nested chunked list" do
      check all(
              list_str <- list_of(string(:alphanumeric, min_length: 1, max_length: 3)),
              list_int <- list_of(integer()),
              size <- integer()
            ) do
        test_function = fn list, chunks ->
          cond do
            list === [] ->
              []

            chunks < 1 ->
              list

            true ->
              Enum.chunk_every(list, chunks)
          end
        end

        assert BasicAlgo.chunk_array_in_groups(["a", "b", "c", "d"], 2) ===
                 [["a", "b"], ["c", "d"]]

        assert BasicAlgo.chunk_array_in_groups([0, 1, 2, 3, 4, 5], 3) ===
                 [[0, 1, 2], [3, 4, 5]]

        assert BasicAlgo.chunk_array_in_groups([0, 1, 2, 3, 4, 5], 2) ===
                 [[0, 1], [2, 3], [4, 5]]

        assert test_function.(["a", "b", "c", "d"], 2) === [["a", "b"], ["c", "d"]]
        assert test_function.([0, 1, 2, 3, 4, 5], 3) === [[0, 1, 2], [3, 4, 5]]
        assert test_function.([0, 1, 2, 3, 4, 5], 2) === [[0, 1], [2, 3], [4, 5]]

        assert BasicAlgo.chunk_array_in_groups(list_str, size) ===
                 test_function.(list_str, size)

        assert BasicAlgo.chunk_array_in_groups(list_int, size) ===
                 test_function.(list_int, size)
      end
    end
  end
end
