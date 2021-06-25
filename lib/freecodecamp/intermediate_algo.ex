defmodule Freecodecamp.IntermediateAlgo do
  @moduledoc """
  Documentation for Freecodecamp (Intermediate Alogrithmic Scripting).
  """

  @doc """
  Pass a list of two integers. Return
  the sum of those two integers plus the sum of
  all the integers between them.

  ## Examples

      iex> IntermediateAlgo.sum_all([1, 4])
      10

      iex> IntermediateAlgo.sum_all([4, 1])
      10

      iex> IntermediateAlgo.sum_all([5, 10])
      45

  """
  @spec sum_all(list(integer())) :: integer()
  def sum_all([0, 0]), do: 0

  def sum_all([num_one, num_two] = _list) do
    to_list(num_one, num_two, [])
    |> sum()
  end

  @spec to_list(integer(), integer(), list(integer())) :: list(integer())
  defp to_list(num_one, num_two, list) when num_one === num_two do
    list ++ [num_one]
  end

  defp to_list(num_one, num_two, list) when num_one <= num_two do
    to_list(num_one + 1, num_two, list ++ [num_one])
  end

  defp to_list(num_one, num_two, list) when num_one >= num_two do
    to_list(num_one - 1, num_two, list ++ [num_one])
  end

  @spec sum(list(integer())) :: integer()
  defp sum([]), do: 0
  defp sum([h | t] = _list), do: h + sum(t)
end
