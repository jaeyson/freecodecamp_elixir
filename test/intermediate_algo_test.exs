defmodule IntermediateAlgoTest do
  use ExUnit.Case, async: true
  use ExUnitProperties, async: true

  alias Freecodecamp.IntermediateAlgo
  doctest Freecodecamp.IntermediateAlgo

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
end
