defmodule ParserTest do
  use ExUnit.Case
  alias BuoyCollection.Parser
  doctest Parser

  test "clean_row_data returns list with removed spaces" do
    sample_row_data = "2020 06 07 04 26  1.8  0.8 14.3  1.6  6.2 SSW   W VERY_STEEP  5.7 270"
    expected_result = ["2020", "06", "07", "04", "26", "1.8", "0.8", "14.3", "1.6", "6.2", "SSW", "W",
    "VERY_STEEP", "5.7", "270"]

    assert Parser.clean_row_data(sample_row_data) == expected_result
  end
end
