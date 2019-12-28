defmodule Freecodecamp.BasicAlgo do
  @moduledoc """
  Documentation for Freecodecamp.
  """

  @doc """
  Convert Celsius to Fahrenheit

  ## Examples

      iex> BasicAlgo.convert_to_f(30)
      86

  """
  @spec convert_to_f(integer) :: integer
  def convert_to_f(celsius) when is_integer(celsius), do: celsius * 9 / 5 + 32
end
