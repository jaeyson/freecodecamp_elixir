defmodule FreecodecampTest do
  use ExUnit.Case
  doctest Freecodecamp

  test "greets the world" do
    assert Freecodecamp.hello() == :world
  end
end
