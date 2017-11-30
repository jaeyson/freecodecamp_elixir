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

```

---
[http://elixir-lang.github.io/getting-started/typespecs-and-behaviours.html](# Typespecs and behaviours)
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
