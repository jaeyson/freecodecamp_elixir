defmodule FreecodecampTest do
  use ExUnit.Case, async: true
  doctest Freecodecamp
  alias Freecodecamp.{BasicAlgo, IntermediateAlgo, AlgoProjects}

  test "greets the world" do
    assert Freecodecamp.hello() == :world
  end

  describe "Convert Celsius to Fahrenheit" do
    test "30Celsius to Fahrenheit = 86" do
      assert BasicAlgo.convert_to_f(30) == 86
    end
  end
end
