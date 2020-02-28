defmodule BasicAlgo do
  use ExUnit.Case, async: true
  # doctest Freecodecamp
  alias Freecodecamp.{AlgoProjects, BasicAlgo, IntermediateAlgo}

  # test "greets the world" do
  #   assert Freecodecamp.hello() == :world
  # end

  describe "Convert Celsius to Fahrenheit:" do
    test "-30C == -22F", do: assert BasicAlgo.convert_to_f(-30) == -22
    test "-10 == 14", do: assert BasicAlgo.convert_to_f(-10) == 14
  end

  describe "Reverse a string:" do
    test "hello should become olleh", do: assert BasicAlgo.reverse_string("hello") == "olleh"
    test "Howdy should become ydwoH", do: assert BasicAlgo.reverse_string("Howdy") == "ydwoH"
  end

  describe "Factorialize a number:" do
    test "!5 == 120", do: assert BasicAlgo.factorialize(5) == 120
    test "!20 == 2_432_902_008_176_640_000", do: assert BasicAlgo.factorialize(20) == 2_432_902_008_176_640_000
    test "!0 == 1", do: assert BasicAlgo.factorialize(0) == 1
  end

  describe "Find the longest word in a string:" do
    test "jumped = 6", do: assert BasicAlgo.find_longest_wordlength("The quick brown fox jumped over the lazy dog") == 6
    test "force = 5", do: assert BasicAlgo.find_longest_wordlength("May the force be with you") == 5
  end

end
