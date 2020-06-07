defmodule ListUtilTest do
  use ExUnit.Case
  alias BuoyCollection.ListUtil
  doctest ListUtil

  test "empty list returns empty map" do
    assert ListUtil.list_to_map([]) == %{}
  end

  test "list with one element returns map with 1 key and default value for that key" do
    assert ListUtil.list_to_map([:a]) == %{a: nil}
    assert ListUtil.list_to_map([:a], "howdy") == %{a: "howdy"}
  end

  test "list with multiple elements returns correct map" do
    assert ListUtil.list_to_map(["a", 1, "b", 2]) == %{"a" => 1, "b" => 2}
    assert ListUtil.list_to_map(["a", 1, "b"], "test_default") == %{"a" => 1, "b" => "test_default"}
  end
end
