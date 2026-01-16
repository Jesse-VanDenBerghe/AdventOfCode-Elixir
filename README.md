# Advent of Code - Elixir Solutions

My [Advent of Code](https://adventofcode.com/) solutions written in Elixir, featuring a clean, minimal-boilerplate architecture using behaviours and Mix tasks.

## Features

- 🎄 **Zero Boilerplate**: Just implement `part1/1` and `part2/1` for each day
- ⚡ **Fast Execution**: Built-in timing for each solution part
- 🧪 **Test-Driven**: Separate test inputs for development
- 🔄 **Auto-Fetch**: Automatically downloads and caches puzzle inputs
- 📝 **Template Generator**: Scaffold new days instantly
- 🏗️ **Behaviour-Based**: Consistent structure enforced via Elixir behaviours

## Quick Start

### Prerequisites

- Elixir 1.19 or later
- An Advent of Code account and session cookie

### Setup

1. **Clone and install dependencies:**
   ```bash
   git clone <your-repo-url>
   cd adventofcode
   mix deps.get
   ```

2. **Set your AOC session cookie:**
   
   Get your session cookie from [adventofcode.com](https://adventofcode.com) (check browser cookies after logging in).
   
   ```bash
   export AOC_SESSION_COOKIE="your_session_cookie_here"
   ```
   
   Add this to your `~/.zshrc` or `~/.bashrc` to make it permanent.

3. **Verify setup:**
   ```bash
   mix test
   ```

## Usage

### Running Solutions

Run any day's solution with the `mix aoc` task:

```bash
# Run with real puzzle input
mix aoc 2025 1

# Run with test input
mix aoc 2025 1 --test
```

**Example output:**
```
=== Advent of Code 2025 - Day 01 ===

Part 1: 42 (1.23ms)
Part 2: 123 (2.45ms)
```

### Creating a New Day

Generate boilerplate for a new day:

```bash
mix aoc.new 2025 2
```

This creates:
- `lib/y2025/d02.ex` - Solution file with behaviour implementation
- `test/y2025/d02_test.exs` - Test file with basic structure
- `inputs/2025/day2.test.txt` - Empty test input file

### Workflow for Each Day

1. **Generate the template:**
   ```bash
   mix aoc.new 2025 2
   ```

2. **Add your test input** to `inputs/2025/day2.test.txt`

3. **Implement your solution** in `lib/y2025/d02.ex`:
   ```elixir
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
       # Your parsing logic
     end

     defp solve_part1(data) do
       # Your solution
     end

     defp solve_part2(data) do
       # Your solution
     end
   end
   ```

4. **Test with test input:**
   ```bash
   mix aoc 2025 2 --test
   ```

5. **Run on real input:**
   ```bash
   mix aoc 2025 2
   ```

## Project Structure

```
adventofcode/
├── lib/
│   ├── aoc/
│   │   ├── solution.ex          # Behaviour definition
│   │   └── runner.ex            # Solution runner with timing
│   ├── mix/
│   │   └── tasks/
│   │       ├── aoc.ex           # Mix task: mix aoc
│   │       └── aoc/
│   │           └── new.ex       # Mix task: mix aoc.new
│   ├── utils/
│   │   └── inputfetcher.ex      # Input fetching and caching
│   └── y2025/
│       ├── d01.ex               # Day 1 solution
│       ├── d02.ex               # Day 2 solution
│       └── ...
├── test/
│   ├── y2025/
│   │   ├── d01_test.exs
│   │   └── ...
│   └── utils/
│       └── test_utils.exs
├── inputs/
│   └── 2025/
│       ├── day1.txt             # Cached real input
│       ├── day1.test.txt        # Test input
│       └── ...
└── mix.exs
```

## Architecture

### AOC.Solution Behaviour

All solution modules implement the `AOC.Solution` behaviour:

```elixir
@callback part1(input :: String.t()) :: any()
@callback part2(input :: String.t()) :: any()
```

This ensures consistency across all solutions and enables the runner to work with any day's implementation.

### Input Handling

- **Real inputs**: Automatically fetched from adventofcode.com and cached in `inputs/<year>/day<day>.txt`
- **Test inputs**: Manually created in `inputs/<year>/day<day>.test.txt`
- **Caching**: Real inputs are cached locally to avoid repeated API calls

### Module Naming Convention

- **Solution modules**: `Y<year>.D<day>` (e.g., `Y2025.D01`)
- **Files**: `lib/y<year>/d<day>.ex` (e.g., `lib/y2025/d01.ex`)
- **Tests**: `test/y<year>/d<day>_test.exs` (e.g., `test/y2025/d01_test.exs`)

Days are zero-padded for better sorting and consistency.

## Testing

Run all tests:
```bash
mix test
```

Run tests for a specific day:
```bash
mix test test/y2025/d01_test.exs
```

Run tests in watch mode (requires `mix_test_watch`):
```bash
mix test.watch
```

## Tips & Best Practices

### Testing Private Functions

You have two options for testing helper functions:

1. **Keep them public** (`def` instead of `defp`) if you want direct test access
2. **Test through the public interface** (`part1/1`, `part2/1`) only

### Organizing Complex Solutions

For complex days, consider extracting logic into separate modules:

```elixir
defmodule Y2025.D15.Grid do
  # Grid-specific logic
end

defmodule Y2025.D15 do
  @behaviour AOC.Solution
  alias Y2025.D15.Grid
  
  # Use Grid module
end
```

### Performance Optimization

The runner displays timing information - use it to identify slow solutions:

```bash
mix aoc 2025 15
# Part 1: 42 (1250.45ms)  # ← This might need optimization!
# Part 2: 123 (2.34ms)
```

### Debugging Tips

1. **Use test input** for development: `mix aoc 2025 1 --test`
2. **Add IO.inspect** to your pipeline for debugging
3. **Run tests** to verify helper functions work correctly
4. **IEx for exploration**: `iex -S mix` then manually call functions

## Common Commands

```bash
# Generate new day
mix aoc.new 2025 5

# Run with test input
mix aoc 2025 5 --test

# Run with real input
mix aoc 2025 5

# Run tests
mix test

# Run specific test file
mix test test/y2025/d05_test.exs

# Compile
mix compile

# Format code
mix format

# Start IEx with project loaded
iex -S mix
```

## Troubleshooting

### "Module not found" error

- Verify file exists at `lib/y<year>/d<day>.ex`
- Check module name matches: `Y<year>.D<day>`
- Recompile: `mix compile --force`

### Input fetching fails

- Verify `AOC_SESSION_COOKIE` environment variable is set
- Check your session hasn't expired (log into adventofcode.com)
- Ensure the puzzle is unlocked (check date/time)

### Tests fail after refactoring

- If testing private functions, either make them public or test through public interface
- Check test file is in correct location: `test/y<year>/d<day>_test.exs`

## Contributing

This is a personal project for learning and practice, but feel free to fork and adapt for your own use!

## License

MIT

## Acknowledgments

- [Advent of Code](https://adventofcode.com/) by Eric Wastl
- Built with [Elixir](https://elixir-lang.org/)
