defmodule Benchmark.BasicAlgo do
  list = Enum.to_list(1..10_000)
  flat_map = & [&1, &1 * &1]

  Benchee.run(%{
    "flat_map" =>
      fn -> Enum.flat_map(list, flat_map) end,

    "map.flatten" =>
      fn -> list |> Enum.map(flat_map) |> List.flatten() end
  })
end
