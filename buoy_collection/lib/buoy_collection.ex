defmodule BuoyCollection do
  defdelegate fetch_buoy_data(buoy_name), to: BuoyCollection.Fetcher
end
