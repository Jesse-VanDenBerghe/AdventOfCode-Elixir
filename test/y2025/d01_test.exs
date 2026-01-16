defmodule Y2025.D01Test do
  use ExUnit.Case
  doctest Y2025.D01

  describe "rotate/2" do
    test "rotates left from zero with distance" do
      result = Y2025.D01.rotate("L10", 0)
      assert result[:endValue] == 90
      assert result[:endedAtZero] == 0
    end

    test "rotates left to zero" do
      result = Y2025.D01.rotate("L100", 0)
      assert result[:endValue] == 0
      assert result[:endedAtZero] == 1
    end

    test "rotates right from zero to distance" do
      result = Y2025.D01.rotate("R10", 0)
      assert result[:endValue] == 10
      assert result[:endedAtZero] == 0
    end

    test "rotates right to zero" do
      result = Y2025.D01.rotate("R100", 0)
      assert result[:endValue] == 0
      assert result[:endedAtZero] == 1
    end

    test "rotates right with distance" do
      result = Y2025.D01.rotate("R20", 90)
      assert result[:endValue] == 10
      assert result[:endedAtZero] == 1
    end

    test "returns start value for invalid input" do
      result = Y2025.D01.rotate("X5", 99)
      assert result[:endValue] == 99
      assert result[:endedAtZero] == 0
    end

    test "rotates left with integer distance" do
      result = Y2025.D01.rotate(-30, 90)
      assert result[:endValue] == 60
      assert result[:endedAtZero] == 0
    end

    test "rotates right with integer distance" do
      result = Y2025.D01.rotate(45, 55)
      assert result[:endValue] == 0
      assert result[:endedAtZero] == 1
    end

    test "rotates left past zero" do
      result = Y2025.D01.rotate(-100, 50)
      assert result[:endValue] == 50
      assert result[:endedAtZero] == 1
    end

    test "rotates right past 100" do
      result = Y2025.D01.rotate(400, 80)
      assert result[:endValue] == 80
      assert result[:endedAtZero] == 4
    end

    test "rotates from zero and lands on zero" do
      result = Y2025.D01.rotate(100, 0)
      assert result[:endValue] == 0
      assert result[:endedAtZero] == 1
    end

    test "rotates left, passes over 0 and ends at 0" do
      result = Y2025.D01.rotate(-150, 50)
      assert result[:endValue] == 0
      assert result[:endedAtZero] == 2
    end

    test "rotates from value and lands on zero" do
      result = Y2025.D01.rotate(-50, 50)
      assert result[:endValue] == 0
      assert result[:endedAtZero] == 1
    end

    test "rotates with large value" do
      result = Y2025.D01.rotate(1000, 90)
      assert result[:endValue] == 90
      assert result[:endedAtZero] == 10
    end

    test "rotates with large negative value" do
      result = Y2025.D01.rotate(-250, 30)
      assert result[:endValue] == 80
      assert result[:endedAtZero] == 3
    end

    test "rotates with zero distance" do
      result = Y2025.D01.rotate(0, 75)
      assert result[:endValue] == 75
      assert result[:endedAtZero] == 0
    end
  end

  describe "rotate_and_count_zero_end/2" do
    test "counts zero endings correctly" do
      Y2025.D01.rotate_and_count_zero_end("L68", {50, 0})
      |> TestUtils.assert_and_return({82, 0})
      |> then(&Y2025.D01.rotate_and_count_zero_end("L30", &1))
      |> TestUtils.assert_and_return({52, 0})
      |> then(&Y2025.D01.rotate_and_count_zero_end("R48", &1))
      |> TestUtils.assert_and_return({0, 1})
    end
  end
end
