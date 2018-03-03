# Freecodecamp exercises using Elixir
Some exercises from freecodecamp.org using Elixir programming language

### Front End Development Certification
  - Basic Algorithm Scripting
    1. [Reverse a String](#reverse-a-string)
    2. [Factorialize a Number](#factorialize-a-number)
    3. [Check for Palindromes](#check-for-palindromes)
    4. [Find the Longest Word in a String](#find-the-longest-word-in-a-string)
    5. [Title Case a Sentence](#title-case-a-sentence)
    6. [Return Largest Numbers in Arrays](#return-largest-numbers-in-arrays)
    7. [Confirm the Ending](#confirm-the-ending)
    8. [Repeat a string repeat a string](#repeat-a-string-repeat-a-string)
    
#### Reverse a String
```elixir
#Reverse a String:
iex> IO.puts(String.reverse("hello"))
olleh
:ok
```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Factorialize a Number
```elixir
#Factorialize a Number:
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
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Check for Palindromes
```elixir
#Check for Palindromes:
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

#IO.puts("foo" =~ ~r/foo/)
```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Find the Longest Word in a String
```elixir
#Find the Longest Word in a String:
defmodule Word do
  def find_longest(str) do
    Enum.map(String.split(str), &(String.length(&1))) |> Enum.max
  end
end

iex> IO.puts Word.find_longest("foo this")
4
:ok


#Find the Longest Word in a String version 2:
defmodule Word do
  def find_longest(str) do
    length = Enum.map(String.split(str), &(String.length(&1))) |> Enum.max
    value = String.split(str) |> Enum.max
    "The longest word: #{value} (#{length} characters)"
  end
end

iex> Word.find_longest("foo this")
"The longest word: this (4 characters)"
```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Title Case a Sentence
```elixir
#Title Case a Sentence:
defmodule Word do
  def title_case(str) do
    Enum.map(String.split(str),
      fn(x) -> String.capitalize(x) end)
    |> Enum.join(" ")
  end
end

iex> Word.title_case("foo this")
"Foo This"
```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Return Largest Numbers in Arrays
```elixir
#Return Largest Numbers in Arrays:
defmodule Array do
  def largest_number(list) do
    for number <- list, do: Enum.max(number)
  end
end

iex> Array.largest_number([[13, 27, 18, 26], [4, 5, 1, 3], [32, 35, 37, 39], [1000, 1001, 857, 1]])
[27, 5, 39, 1001]
```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Confirm the Ending
```elixir
#Confirm the Ending:
defmodule Word do
  def confirm_ending(string, match_string) do
    start = (String.length(match_string))
    pattern = String.slice(string, -start, start)
    match_string == pattern
  end
end

iex> Word.confirm_ending("bastion","ion")
true

iex> Word.confirm_ending("bastion","Ion")
false

#or use the built-in function
iex> String.ends_with?("bastion", "ion")
true

iex> String.ends_with?("bastion", "Ion")
false
```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**

#### Repeat a string repeat a string
```elixir
#Repeat a string repeat a string

```
**[⬆ back to top](#freecodecamp-exercises-using-elixir)**
