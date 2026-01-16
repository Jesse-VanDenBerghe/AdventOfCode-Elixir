defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @shortdoc "Runs an Advent of Code solution"

  @moduledoc """
  Runs and Advent of Code solution for a specific year and day.

  ## Usage

  mix aoc 2025 1
  mix aoc 2025 1 --test

  ## Options

  * `--test` - Use test input instead of real puzzle input
  """

  @impl Mix.Task
  def run(args) do
    Mix.Task.run("app.start")

    {opts, args, _invalid} = OptionParser.parse(args, strict: [test: :boolean])

    case args do
      [year_str, day_str] ->
        with {year, ""} <- Integer.parse(year_str),
             {day, ""} <- Integer.parse(day_str) do
          test = Keyword.get(opts, :test, false)
          AOC.Runner.run(year, day, test)
        else
          _ ->
            IO.puts("Error: Year and day must be valid integers")
            print_usage()
        end

      _ ->
        IO.puts("Error: Invalid arguments")
        print_usage()
    end
  end

  defp print_usage do
    IO.puts("\nUsage: mix aoc <year> <day> [--test]")
    IO.puts("\nExamples")
    IO.puts(" mix aoc 2025 1")
    IO.puts(" mix aoc 2025 1 --test")
  end
end
