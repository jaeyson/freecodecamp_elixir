# Freecodecamp.org exercises using Elixir
some exercises from freecodecamp.org using Elixir programming language

```elixir
#Reverse a String:
IO.puts(String.reverse("hello"))
--> "olleh"
```

```elixir
#Factorialize a Number:
defmodule Math do
  def factorial(0), do: 1
  def factorial(n) when n > 0 do
    n * (factorial(n-1))
  end
end

IO.puts(Math.factorial(3))
# or IO.puts Math.factorial(3)
--> 6
```

```elixir
#Check for Palindromes:
defmodule Word do
  #@spec is_palindrome?(char) :: String
  
  def is_palindrome?(char) do
    #old = Regex.scan(~r/[^\s+^\W+]/i, char)
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
