defmodule BuoyCollection.Parser do
  alias BuoyCollection.BuoyData

  @doc """
  parse_row_to_map(row_data) takes a string of row data from the response, and parses its values into a BuoyData struct
  """
  @spec parse_row_to_struct(String.t(), String.t()) :: %BuoyData{}
  def parse_row_to_struct(row_data, buoy_name) do
    row_data
    |> clean_row_data(buoy_name)
    |> inject_keys_into_row_data()
    |> keys_and_data_to_struct()
    |> parse_numbers()
    |> convert_meters_to_feet()
  end

  ####################################################

  @spec clean_row_data(String.t(), String.t()) :: list
  defp clean_row_data(row_data, buoy_name) do
    ("#{buoy_name} " <> row_data)
    |> String.split(" ")
    |> Enum.filter(fn elem -> elem != "" end)
  end

  @spec inject_keys_into_row_data(list) :: list
  defp inject_keys_into_row_data(row_data) do
    List.zip([atom_keys(), row_data])
  end

  @spec keys_and_data_to_struct(list) :: %BuoyData{}
  defp keys_and_data_to_struct(buoy_data_with_keys) do
    struct(BuoyCollection.BuoyData, buoy_data_with_keys)
  end

  @spec convert_meters_to_feet(%BuoyData{}) :: %BuoyData{}
  defp convert_meters_to_feet(buoy_data = %BuoyData{wave_height: wh, swell_height: sh, wind_wave_height: wwh}) do
    %BuoyData{buoy_data | wave_height: to_feet(wh), swell_height: to_feet(sh), wind_wave_height: to_feet(wwh)}
  end

  @spec to_feet(number) :: float
  defp to_feet(value), do: Float.round(value * 3.28084, 3)

  defp atom_keys do
    [
      :buoy_name,
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

  ####################################################
  # parse helper functions

  @spec parse_numbers(%BuoyData{}) :: %BuoyData{}
  defp parse_numbers(buoy_data = %BuoyData{}) do
    buoy_data
    |> parse_integers()
    |> parse_floats()
  end

  defp parse_integers(buoy_data = %BuoyData{year: year, month: month, day: day, hour: hour, minute: minute}) do
    %BuoyData{
      buoy_data
      | year: parse(year),
        month: parse(month),
        day: parse(day),
        hour: parse(hour),
        minute: Integer.parse(minute)
    }
  end

  defp parse_floats(
         buoy_data = %BuoyData{
           average_wave_period: awp,
           mean_wave_direction: mwd,
           swell_height: sh,
           swell_period: sp,
           wave_height: wh,
           wind_wave_height: wwh,
           wind_wave_period: wwp
         }
       ) do
    %BuoyData{
      buoy_data
      | average_wave_period: parse(awp),
        mean_wave_direction: parse(mwd),
        swell_height: parse(sh),
        swell_period: parse(sp),
        wave_height: parse(wh),
        wind_wave_height: parse(wwh),
        wind_wave_period: parse(wwp)
    }
  end

  defp parse(value) do
    handle_parse(value, String.contains?(value, "."))
  end

  defp handle_parse(num, _is_float = true) do
    case Float.parse(num) do
      {val, _} -> val
      :error -> raise ArgumentError, message: "#{num} cannot be parsed to a float"
    end
  end

  defp handle_parse(num, _is_float = false) do
    case Integer.parse(num) do
      {val, _} -> val
      :error -> raise ArgumentError, message: "#{num} cannot be parsed to an integer"
    end
  end

  # no longer being used, but saved for potential further use
  # defp keys do
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
