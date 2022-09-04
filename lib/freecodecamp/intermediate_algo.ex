defmodule Freecodecamp.IntermediateAlgo do
  @moduledoc """
  Documentation for Freecodecamp (Intermediate Alogrithmic Scripting).
  """
  @moduledoc since: "0.1.0"

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
  @spec sum_all([integer]) :: integer
  def sum_all([0, 0]), do: 0

  def sum_all([num_one, num_two] = _list) do
    to_list(num_one, num_two, [])
    |> sum()
  end

  @spec to_list(integer, integer, [integer]) :: [integer]
  defp to_list(num_one, num_two, list) when num_one === num_two do
    list ++ [num_one]
  end

  defp to_list(num_one, num_two, list) when num_one <= num_two do
    to_list(num_one + 1, num_two, list ++ [num_one])
  end

  defp to_list(num_one, num_two, list) when num_one >= num_two do
    to_list(num_one - 1, num_two, list ++ [num_one])
  end

  @spec sum([integer]) :: integer
  defp sum([]), do: 0
  defp sum([h | t] = _list), do: h + sum(t)

  @doc """
  Compare two arrays and return a new array
  with any items only found in one of the
  two given arrays, but not both. In other
  words, return the symmetric difference of
  the two arrays.

  It returns either an list of empty or
  unsorted element(s).

  source: [Diff Two Arrays](https://www.freecodecamp.org/learn/javascript-algorithms-and-data-structures/intermediate-algorithm-scripting/diff-two-arrays)

  ## Examples

      iex> IntermediateAlgo.diff_list(["andesite", "grass", "dirt", "pink wool", "dead shrub"], ["diorite", "andesite", "grass", "dirt", "dead shrub"])
      ["diorite", "pink wool"]

      iex> IntermediateAlgo.diff_list(["andesite", "grass", "dirt", "dead shrub"],["andesite", "grass", "dirt", "dead shrub"])
      []

      iex> IntermediateAlgo.diff_list([1, 2, 3, 5], [1, 2, 3, 4, 5])
      [4]

      iex> IntermediateAlgo.diff_list([1, 2, 3, 5], [])
      [1, 2, 3, 5]

      iex> IntermediateAlgo.diff_list([1, "calf", 3, "piglet"], [1, "calf", 3, 4])
      [4, "piglet"]

  """
  @doc since: "0.1.0"
  @spec diff_list(list(any), list(any)) :: [] | list(any)
  def diff_list([], list), do: list
  def diff_list(list, []), do: list

  def diff_list(list_one, list_two),
    do: do_diff_list(list_one ++ list_two, [], [])

  defp do_diff_list([], _dups, result), do: result

  defp do_diff_list([h | t], dups, result) do
    if h in t or h in dups do
      do_diff_list(t, [h | dups], result)
    else
      do_diff_list(t, dups, [h | result])
    end
  end
end
