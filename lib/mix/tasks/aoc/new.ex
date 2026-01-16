defmodule Mix.Tasks.Aoc.New do
  use Mix.Task

  @shortdoc "Generates a new Advent of Code solution template"

  @moduledoc """
  Generates boilerplate for a new Advent of Code solution.

  ## Usage
    mix aoc.new <year> <day>

  ## Examples
    mix aoc.new 2025 2
    mix aoc.new 2025 15

  This will create:
    - lib/y<year>/d<day>.ex (solution file)
    - test/y<year>/d<day>_test.exs (test file)
    - inputs/y<year>/day<day>.test.txt
  """

  @impl Mix.Task
  def run(args) do
    case args do
      [year_str, day_str] ->
        with {year, ""} <- Integer.parse(year_str),
             {day, ""} <- Integer.parse(day_str) do
          generate(year, day)
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

  defp generate(year, day) do
    day_padded = String.pad_leading("#{day}", 2, "0")
    module_name = "Y#{year}.D#{day_padded}"

    # Create solution file
    solution_path = "lib/y#{year}/d#{day_padded}.ex"
    test_path = "test/y#{year}/d#{day_padded}_test.exs"
    input_path = "inputs/#{year}/day#{day}.test.txt"

    # Ensure directories exist
    File.mkdir_p!(Path.dirname(solution_path))
    File.mkdir_p!(Path.dirname(test_path))
    File.mkdir_p!(Path.dirname(input_path))

    # Generate solution file
    if File.exists?(solution_path) do
      IO.puts("⚠️  Solution file already exists: #{solution_path}")
    else
      File.write!(solution_path, solution_template(module_name, year, day))
      IO.puts("✓ Created #{solution_path}")
    end

    # Generate test file
    if File.exists?(test_path) do
      IO.puts("⚠️  Test file already exists: #{test_path}")
    else
      File.write!(test_path, test_template(module_name))
      IO.puts("✓ Created #{test_path}")
    end

    # Generate test input file
    if File.exists?(input_path) do
      IO.puts("⚠️  Test input file already exists: #{input_path}")
    else
      File.write!(input_path, "")
      IO.puts("✓ Created #{input_path}")
    end

    IO.puts("\n🎄 Ready to solve Day #{day}!")
    IO.puts("\nNext steps:")
    IO.puts("  1. Add your test input to: #{input_path}")
    IO.puts("  2. Implement your solution in: #{solution_path}")
    IO.puts("  3. Run with: mix aoc #{year} #{day} --test")
  end

  defp solution_template(module_name, year, day) do
    """
    # https://adventofcode.com/#{year}/day/#{day}

    defmodule #{module_name} do
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
        |> String.split("\\n", trim: true)
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
    """
  end

  defp test_template(module_name) do
    """
    defmodule #{module_name}Test do
      use ExUnit.Case
      doctest #{module_name}
      @test_input \"\"\"
      \"\"\"

      describe "part1/1" do
        test "solves test input" do
          assert #{module_name}.part1(@test_input) == :expected_result
        end
      end

      describe "part2/1" do
        test "solves test input" do
          assert #{module_name}.part2(@test_input) == :expected_result
        end
      end
    end
    """
  end

  defp print_usage do
    IO.puts("\nUsage: mix aoc.new <year> <day>")
    IO.puts("\nExample: mix aoc.new 2025 2")
  end
end
