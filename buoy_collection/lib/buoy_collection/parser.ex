defmodule BuoyCollection.Parser do
  alias BuoyCollection.BuoyData

  @doc """
  parse_row_to_map(row_data) takes a string of row data from the response, and parses its values into a BuoyData struct
  """
  @spec parse_row_to_struct(String.t()) :: %BuoyData{}
  def parse_row_to_struct(row_data) do
    row_data
    |> clean_row_data()
    |> inject_keys_into_row_data()
    |> keys_and_data_to_struct()
  end

  # ! make all functions below this line private

  @spec clean_row_data(String.t()) :: list
  def clean_row_data(row_data) do
    row_data
    |> String.split(" ")
    |> Enum.filter(fn elem -> elem != "" end)
  end

  @spec inject_keys_into_row_data(list) :: list
  def inject_keys_into_row_data(row_data) do
    List.zip([atom_keys(), row_data])
  end

  @spec keys_and_data_to_struct(list) :: %BuoyData{}
  def keys_and_data_to_struct(buoy_data_with_keys) do
    struct(BuoyCollection.BuoyData, buoy_data_with_keys)
  end

  def atom_keys do
    [
      :year,
      :month,
      :day,
      :hour,
      :minute,
      :wave_height,
      :swell_height,
      :swell_period,
      :wind_wave_height,
      :wind_wave_period,
      :swell_direction,
      :wind_wave_direction,
      :steepness,
      :average_wave_period,
      :mean_wave_direction
    ]
  end

  # no longer being used, but saved for potential further use
  # def keys do
  #   [
  #     "year",
  #     "month",
  #     "day",
  #     "hour",
  #     "minute",
  #     "wave_height",
  #     "swell_height",
  #     "swell_period",
  #     "wind_wave_height",
  #     "wind_wave_period",
  #     "swell_direction",
  #     "wind_wave_direction",
  #     "steepness",
  #     "average_wave_period",
  #     "mean_wave_direction"
  #   ]
  # end
end
