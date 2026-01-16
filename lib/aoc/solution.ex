defmodule AOC.Solution do
  @moduledoc """
  Behavior for Advent of Code solution modules.

  Ech day's solution should implement this behavior providing implementations for
  `part1/1` and `part2/1` that accept the raw input string and return the solution result.
  """

  @callback part1(input :: String.t()) :: any()
  @callback part2(input :: String.t()) :: any()
end
