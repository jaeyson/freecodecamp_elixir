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
  def convert_to_f(celsius \\ 0) when is_integer(celsius), do: celsius * 9 / 5 + 32

  def reverse_string(str) when is_binary(str), do: String.reverse str

  def factorialize(0), do: 1
  def factorialize(n) when is_integer(n), do: n * factorialize(n - 1)

  def find_longest_wordlength(""), do: 0
  def find_longest_wordlength(str) when is_binary(str) do
    str
    |> String.split()
    |> Enum.max_by(&String.length &1)
    |> String.length()
  end
end
