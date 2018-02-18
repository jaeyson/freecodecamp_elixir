# Freecodecamp.org exercises using Elixir
Some exercises from freecodecamp.org using Elixir programming language

### Front End Development Certification
  - Basic Algorithm Scripting
    1. [Reverse a String](#reverse-a-string)
    2. [Factorialize a Number](#factorialize-a-number)
    3. [Check for Palindromes](#check-for-palindromes)

#### Reverse a String
```elixir
#Reverse a String:
iex> IO.puts(String.reverse("hello"))
olleh
:ok
```
**[⬆ back to top](#front-end-development-certification)**

#### Factorialize a Number
```elixir
#Factorialize a Number:
defmodule Math do
  def factorial(0), do: 1
  def factorial(n) when n > 0 do
    n * (factorial(n-1))
  end
end

iex(23)> IO.puts(Math.factorial(3)) # or IO.puts Math.factorial(3)
6
:ok
```
**[⬆ back to top](#front-end-development-certification)**

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

IO.puts Word.is_palindrome?("A nut for a jar of tuna") #true
IO.puts Word.is_palindrome?(".,.,.,") #true, ???
IO.puts Word.is_palindrome?("142321") #false
#IO.puts("foo" =~ ~r/foo/)
```
**[⬆ back to top](#front-end-development-certification)**

#### Find the Longest Word in a String
```elixir
#Find the Longest Word in a String:
defmodule Word do
  def find_longest(str) do
    Enum.map(String.split(str), &(String.length(&1))) |> Enum.max
  end
end

IO.puts Word.find_longest("foo this") #4



#Find the Longest Word in a String version 2:
defmodule Word do
  def find_longest(str) do
    length = Enum.map(String.split(str), &(String.length(&1))) |> Enum.max
    value = String.split(str) |> Enum.max
    "The longest word: #{value} (#{length} characters)"
  end
end

Word.find_longest("foo this") #"The longest word: this (4 characters)"
```
**[⬆ back to top](#front-end-development-certification)**

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

iex(19)> Word.title_case("foo this")
"Foo This"
```


---
[Typespecs and behaviours](http://elixir-lang.github.io/getting-started/typespecs-and-behaviours.html)
```elixir
# Defining custom types
defmodule Math do
  @spec sum(number) :: {number, Integer.t}
  def sum(x,y \\ 0) do
    x+y
  end
end
IO.puts Math.sum(1,2)
--> 3

# Function specifications
defmodule Math do
  @spec sum(number) :: Integer
  def sum(x,y \\ 0) do
    x+y
  end
end
IO.puts Math.sum(1,2)
--> 3
```
