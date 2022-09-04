defmodule IntermediateAlgoTest do
  use ExUnit.Case, async: true
  use ExUnitProperties, async: true

  alias FreecodecampElixir.IntermediateAlgo
  doctest FreecodecampElixir.IntermediateAlgo

  @tag :intermediate_algo
  describe "Intermediate Algorithm Scripting: Sum All Numbers in a Range" do
    property "takes a list of 2 integers as range and sums it" do
      check all(
              int1 <- positive_integer(),
              int2 <- positive_integer()
            ) do
        assert IntermediateAlgo.sum_all([int1, int2]) === Enum.sum(int1..int2)
      end
    end
  end

  @tag :intermediate_algo
  describe "Diff Two Arrays" do
    property "compares between lists and returns list of unique element(s) or empty" do
      check all(
              list_one <-
                list_of(one_of([integer(), string(:alphanumeric, min_length: 3, max_length: 20)]),
                  min_length: 3,
                  max_length: 10
                ),
              list_two <-
                list_of(one_of([integer(), string(:alphanumeric, min_length: 3, max_length: 20)]),
                  min_length: 3,
                  max_length: 10
                )
            ) do
        test_function = fn list_one, list_two ->
          (list_one ++ list_two)
          |> Enum.frequencies()
          |> Enum.reduce([], fn {k, v}, acc ->
            if v === 1 do
              [k | acc]
            else
              acc
            end
          end)
          |> Enum.sort()
        end

        diff_list = fn list_one, list_two ->
          IntermediateAlgo.diff_list(list_one, list_two)
          |> Enum.sort()
        end

        assert test_function.([], []) === []
        assert diff_list.([], []) === []
        assert diff_list.(list_one, list_two) === test_function.(list_one, list_two)
      end
    end
  end
end
