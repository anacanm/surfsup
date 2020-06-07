defmodule FetcherTest do
  use ExUnit.Case
  alias BuoyCollection.Fetcher
  doctest Fetcher

  test "buoy_id!(buoy_name) raises error when passed a non-existent buoy name" do
    assert_raise KeyError, fn -> Fetcher.buoy_id!("non existent name") end
  end

  test "buoy_id!(buoy_name) returns correct id when passed a valid buoy name" do
    assert Fetcher.buoy_id!("   SAntA MoNICA BaY    ") == 46221
  end
end
