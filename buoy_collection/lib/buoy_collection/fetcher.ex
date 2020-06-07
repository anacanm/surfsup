defmodule BuoyCollection.Fetcher do
  alias BuoyCollection.{Parser}

  @spec fetch_buoy_data(String.t()) :: list(map)
  def fetch_buoy_data(buoy_name) do
    request!(buoy_id!(buoy_name))
    |> response_to_list()
    |> buoy_data_without_headers(100)
    |> buoy_data_to_list_of_maps()
  end

  # ! make functions below this line private
  def request!(buoy_id) do
    %HTTPoison.Response{body: body} =
      HTTPoison.get!("https://www.ndbc.noaa.gov/data/realtime2/#{buoy_id}.spec")

    body
  end

  def buoy_data_without_headers(buoy_data, num_elements) do
    buoy_data |> Enum.slice(2, num_elements)
  end

  def response_to_list(response) do
    response |> String.split("\n")
  end

  def buoy_data_to_list_of_maps(buoy_data) do
    buoy_data
    |> Enum.map(&Parser.parse_row_to_map/1)
  end

  def buoy_id!(buoy_name) do
    buoys = %{"santa monica bay" => 46221}

    buoy_name =
      buoy_name
      |> String.trim()
      |> String.downcase()

    Map.fetch!(buoys, buoy_name)
  end
end
