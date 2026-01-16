defmodule AOC.Runner do
  @moduledoc """
  Utilities for running Advent of Code solutions with timing and formatting.
  """

  @doc """
  Runs both parts of a solution for a given year and day.

  ## Parameters
  - year: The year of the puzzle (e.g., 2025)
  - day: The day number (e.g., 1)
  - test: Wheter to use the test input (default: false)
  """
  def run(year, day, test \\ false) do
    module = get_module(year, day)

    case Code.ensure_loaded(module) do
      {:module, _} ->
        input = fetch_input(year, day, test)

        IO.puts(
          "\n=== Advent of Code #{year} - Day #{String.pad_leading("#{day}", 2, "0")} ===\n"
        )

        if test, do: IO.puts("(Using test input)\n")

        run_part(module, :part1, input, "Part 1")
        run_part(module, :part2, input, "Part 2")

        IO.puts("")

      {:error, _} ->
        IO.puts("Error: Solution module #{inspect(module)} not found")
        IO.puts("Expected file: lib/y#{year}/d#{String.pad_leading("#{day}", 2, "0")}.ex")
        {:error, :module_not_found}
    end
  end

  defp run_part(module, part, input, label) do
    {time_micro, result} = :timer.tc(fn -> apply(module, part, [input]) end)
    time_ms = time_micro / 1000

    IO.puts("#{label}: #{result} (#{Float.round(time_ms, 2)} ms)")
  rescue
    e ->
      IO.puts("#{label}: Error - #{Exception.message(e)}")
      IO.puts(Exception.format_stacktrace(__STACKTRACE__))
  end

  defp fetch_input(year, day, test) do
    if test do
      InputFetcher.test_input(year, day)
    else
      InputFetcher.input(year, day)
    end
  end

  defp get_module(year, day) do
    day_str = String.pad_leading("#{day}", 2, "0")
    Module.concat(["Y#{year}", "D#{day_str}"])
  end
end
