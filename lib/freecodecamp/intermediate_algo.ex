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
    for(x <- num_one..num_two, do: x)
    |> do_sum_all()
  end

  defp do_sum_all([]), do: 0
  defp do_sum_all([h | t] = _list), do: h + do_sum_all(t)
end
