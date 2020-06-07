defmodule BuoyCollection do
  defdelegate fetch_buoy_data(buoy_id), to: BuoyCollection.Fetcher
end
