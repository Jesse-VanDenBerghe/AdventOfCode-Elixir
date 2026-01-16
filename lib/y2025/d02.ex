defmodule Y2025.D02 do
  @behaviour AOC.Solution

  @impl true
  def part1(input) do
    input
    |> parse()
    |> solve_part1()
  end

  @impl true
  def part2(input) do
    input
    |> parse()
    |> solve_part2()
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    # TODO: Add parsing logic
  end

  defp solve_part1(data) do
    # TODO: Implement part 1
    0
  end

  defp solve_part2(data) do
    # TODO: Implement part 2
    0
  end
end
