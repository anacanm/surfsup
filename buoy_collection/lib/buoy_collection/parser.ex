defmodule BuoyCollection.Parser do
  alias BuoyCollection.ListUtil

  def parse_row_to_map(row_data) when is_bitstring(row_data) do
    row_data
    |> clean_row_data()
    |> inject_keys_into_row_data()
    |> ListUtil.list_to_map()
  end

  # ! make all functions below this line private

  def clean_row_data(row_data) do
    row_data
    |> String.split(" ")
    |> Enum.filter(fn elem -> elem != "" end)
  end

  def inject_keys_into_row_data(row_data) do
    List.zip([keys(), row_data])
    |> ListUtil.flatten_list_of_tuples()
  end

  def keys do
    [
      "year",
      "month",
      "day",
      "hour",
      "minute",
      "wave_height",
      "swell_height",
      "swell_period",
      "wind_wave_height",
      "wind_wave_period",
      "swell_direction",
      "wind_wave_direction",
      "steepness",
      "average_wave_period",
      "mean_wave_direction"
    ]
  end
end
