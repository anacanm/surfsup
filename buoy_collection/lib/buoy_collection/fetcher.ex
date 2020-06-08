defmodule BuoyCollection.Fetcher do
  alias BuoyCollection.{Parser, BuoyData}

  @spec fetch_buoy_data(String.t()) :: list(%BuoyData{})
  def fetch_buoy_data(buoy_name) do
    request!(buoy_id!(buoy_name))
    |> response_to_list()
    |> buoy_data_without_headers(100)
    |> buoy_data_to_list_of_structs()
  end

  ###############################################################################
  @spec request!(integer) :: String.t()
  defp request!(buoy_id) do
    %HTTPoison.Response{body: body} = HTTPoison.get!("https://www.ndbc.noaa.gov/data/realtime2/#{buoy_id}.spec")

    body
  end

  @spec response_to_list(String.t()) :: list(String.t())
  defp response_to_list(response) do
    response |> String.split("\n")
  end

  @spec buoy_data_without_headers(list(String.t()), integer) :: list(String.t())
  defp buoy_data_without_headers(buoy_data, num_elements) do
    buoy_data |> Enum.slice(2, num_elements)
  end

  @spec buoy_data_to_list_of_structs(list(Strint.t())) :: list(%BuoyData{})
  defp buoy_data_to_list_of_structs(buoy_data) do
    buoy_data
    |> Enum.map(&Parser.parse_row_to_struct/1)
  end

  defp buoy_id!(buoy_name) do
    buoys = %{"santa monica bay" => 46221}

    buoy_name =
      buoy_name
      |> String.trim()
      |> String.downcase()

    Map.fetch!(buoys, buoy_name)
  end
end
