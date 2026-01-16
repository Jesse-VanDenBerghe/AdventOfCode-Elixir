# https://adventofcode.com/2025/day/1

defmodule Y2025.D01 do
  @behaviour AOC.Solution

  @impl true
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({50, 0}, &rotate_and_count_zero_end/2)
    |> elem(1)
  end

  @impl true
  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({50, 0}, &rotate_and_count_zero_passes/2)
    |> elem(1)
  end

  def rotate_and_count_zero_end(line, {current_value, zero_count}) do
    result = rotate(line, current_value)

    zero_count =
      if result.endValue == 0 do
        zero_count + 1
      else
        zero_count
      end

    {result.endValue, zero_count}
  end

  def rotate_and_count_zero_passes(line, {current_value, zero_count}) do
    result = rotate(line, current_value)

    zero_count = zero_count + result.endedAtZero

    {result.endValue, zero_count}
  end

  def rotate("L" <> dist, start) do
    amount = -String.to_integer(dist)
    rotate(amount, start)
  end

  def rotate("R" <> dist, start) do
    amount = String.to_integer(dist)
    rotate(amount, start)
  end

  def rotate(dist, start) when is_integer(dist) do
    raw_end = start + dist
    end_value = rem(rem(raw_end, 100) + 100, 100)

    ended_at_zero =
      cond do
        dist == 0 ->
          0

        dist > 0 ->
          first_crossing = div(start, 100) * 100 + 100

          if raw_end >= first_crossing do
            div(raw_end - first_crossing, 100) + 1
          else
            0
          end

        dist < 0 ->
          abs_dist = abs(dist)

          cond do
            start == 0 ->
              div(abs_dist, 100)

            abs_dist >= start ->
              1 + div(abs_dist - start, 100)

            true ->
              0
          end
      end

    %{:endValue => end_value, :endedAtZero => ended_at_zero}
  end

  def rotate(_, start) do
    %{:endValue => start, :endedAtZero => 0}
  end
end
