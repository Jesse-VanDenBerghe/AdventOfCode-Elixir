defmodule TestUtils do
  import ExUnit.Assertions

  def assert_and_return(value, expected) do
    assert value == expected
    value
  end
end
