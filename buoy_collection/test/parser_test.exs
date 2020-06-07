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

  test "insert_keys_into_row_data" do
    sample_row_data = ["2020", "06", "07", "15", "26", "1.5", "0.5", "15.4", "1.4", "7.1", "SSW",
    "WSW", "STEEP", "6.4", "256"]

    expected_result = [
      year: "2020",
      month: "06",
      day: "07",
      hour: "15",
      minute: "26",
      wave_height: "1.5",
      swell_height: "0.5",
      swell_period: "15.4",
      wind_wave_height: "1.4",
      wind_wave_period: "7.1",
      swell_direction: "SSW",
      wind_wave_direction: "WSW",
      steepness: "STEEP",
      average_wave_period: "6.4",
      mean_wave_direction: "256"
    ]
    assert Parser.inject_keys_into_row_data(sample_row_data) == expected_result
  end
end
