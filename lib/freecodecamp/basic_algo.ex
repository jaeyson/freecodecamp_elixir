defmodule Freecodecamp.BasicAlgo do
  # @type word() :: String.t()

  @moduledoc """
  Documentation for Freecodecamp (Basic Alogrithmic Scripting).
  """

  @doc """
  Convert Celsius to Fahrenheit

  ## Examples

      iex> BasicAlgo.convert_to_f(30)
      86

  """
  @spec convert_to_f(integer) :: integer
  def convert_to_f(celsius \\ 0) when is_integer(celsius), do: div(celsius * 9, 5) + 32

  # def convert_to_f(celsius \\ 0) when is_integer(celsius), do: celsius * 9 / 5 + 32

  @spec reverse_string(String.t()) :: String.t()
  defdelegate reverse_string(str), to: String, as: :reverse

  @doc """
  Factorialize a number

  ## Examples

      iex> BasicAlgo.factorialize(0)
      1

      iex> BasicAlgo.factorialize(5)
      120

  """
  @spec factorialize(integer) :: integer
  def factorialize(0), do: 1
  def factorialize(n) when is_integer(n), do: n * factorialize(n - 1)

  @doc """
  Find the longest word and returns the length of it

  ## Examples

      iex> BasicAlgo.find_longest_wordlength("")
      0

      iex> BasicAlgo.find_longest_wordlength("May the force be with you")
      5

  """
  @spec find_longest_wordlength(String.t()) :: integer
  def find_longest_wordlength(""), do: 0

  def find_longest_wordlength(str) when is_binary(str) do
    str |> String.split() |> Enum.max_by(&String.length(&1)) |> String.length()
  end
end
