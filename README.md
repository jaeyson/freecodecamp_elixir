[![Build Status](https://img.shields.io/badge/status-work%20in%20progress-orange.svg)](https://learn.freecodecamp.org/)

# Freecodecamp exercises using Elixir
Some exercises from freecodecamp.org using Elixir programming language

## Basic cli usage (local docs)

```bash
# install dependencies
mix deps.get

# generate docs, view them at doc/index.html
mix docs
```

### Basic Algorithm Scripting

  <details><summary>Reverse a String</summary>

  ```elixir
  # Reverse a String:
  iex> IO.puts(String.reverse("hello"))
  olleh
  :ok
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Factorialize a Number</summary>

  ```elixir
  # Factorialize a Number:
  defmodule Math do
    def factorial(0), do: 1
    def factorial(n) when n > 0 do
      n * (factorial(n-1))
    end
  end

  iex> IO.puts(Math.factorial(3)) # or IO.puts Math.factorial(3)
  6
  :ok
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Check for Palindromes</summary>

  ```elixir
  # Check for Palindromes:
  defmodule Word do
    @spec is_palindrome?(char) :: String
    def is_palindrome?(char) do
      old = Regex.scan(~r/[^\s+^\W+]/i,char)
              |> Enum.join
              |> String.downcase

      old === String.reverse(old)
    end
  end

  iex> IO.puts Word.is_palindrome?("A nut for a jar of tuna")
  true
  :ok

  % IO.puts("foo" =~ ~r/foo/)
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Find the Longest Word in a String</summary>

  ```elixir
  # Find the Longest Word in a String:
  defmodule Word do
    def find_longest(str) do
      str
      |> String.split()
      |> Enum.map(&String.length/1)
      |> Enum.max()
    end
  end

  iex> IO.puts Word.find_longest("foo this")
  4
  :ok


  # Find the Longest Word in a String version 2:
  defmodule Word do
    def find_longest(str) do
      length = str
      |> String.split()
      |> Enum.map(&String.length/1)
      |> Enum.max()
      
      value = str
      |> String.split()
      |> Enum.max()
      
      IO.puts "The longest word: #{value} (#{length} characters)"
    end
  end

  iex> Word.find_longest("foo this")
  "The longest word: this (4 characters)"
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Title Case a Sentence</summary>

  ```elixir
  # Title Case a Sentence:
  defmodule Word do
    def title_case(str) do
      str
      |> String.split()
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(" ")
    end
  end

  iex> IO.puts Word.title_case("foo this")
  "Foo This"
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Return Largest Numbers in Arrays</summary>

  ```elixir
  # Return Largest Numbers in Arrays:
  defmodule Lists do
    def largest_number(list) do
      for number <- list, do: Enum.max(number)
    end
  end

  iex> Lists.largest_number([[13, 27, 18, 26], [4, 5, 1, 3], [32, 35, 37, 39], [1000, 1001, 857, 1]])
  [27, 5, 39, 1001]
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Confirm the Ending</summary>

  ```elixir
  # Confirm the Ending:
  defmodule Word do
    def confirm_ending(string, match_string) do

      start = match_string |> String.length()

      pattern = String.slice(string, -start, start)

      match_string == pattern
    end
  end

  iex> Word.confirm_ending("bastion","ion")
  true

  iex> Word.confirm_ending("bastion","Ion")
  false

  # or use the built-in function
  iex> String.ends_with?("bastion", "ion")
  true

  iex> String.ends_with?("bastion", "Ion")
  false
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>

  <details><summary>Repeat a string repeat a string</summary>

  ```elixir
  # Repeat a string repeat a string:
  iex> String.duplicate("world", 2)
  "worldworld"

  # or another way:
  duplicate = fn string, number -> :binary.copy(string, number) end
  iex> duplicate.("the", 2)
  "thethe"
  ```
  **[⬆ back to top](#basic-algorithm-scripting)**
  </details>
