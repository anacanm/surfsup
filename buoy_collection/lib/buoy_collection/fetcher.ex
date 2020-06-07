defmodule BuoyCollection.Fetcher do
  alias BuoyCollection.{Parser}

  def fetch_buoy_data(buoy_id) do
    request!(buoy_id)
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
end
