defmodule BuoyCollection.ListUtil do
  @moduledoc """
  BuoyCollection.ListUtil provides extra functionality to work with lists
  """

  @doc """
  list_to_map(list) returns a map where even-indexed elements from the list are used as keys, and odd-indexed elements are used as their values
  if a list with an odd number of keys is passed, the last element in the list is used as a key with the default value

  ## Examples
      iex> BuoyCollection.ListUtil.list_to_map([:a, 1, :b, 2])
      %{a: 1, b: 2}

      iex> BuoyCollection.ListUtil.list_to_map([:a, 1, "b"], "default_val")
      %{:a => 1, "b" => "default_val"}
  """
  @spec list_to_map(list, any, any) :: map
  def list_to_map(list, default \\ nil, acc \\ [])

  def list_to_map([a, b | tail], default, acc), do: list_to_map(tail, default, [{a, b} | acc])
  def list_to_map([a | tail], default, acc), do: list_to_map(tail, default, [{a, default} | acc])
  def list_to_map(_, _, acc), do: Map.new(acc)

  @spec flatten_list_of_tuples(list, any) :: list
  def flatten_list_of_tuples(list, acc \\ [])

  def flatten_list_of_tuples([{a, b} | tail], acc), do: flatten_list_of_tuples(tail, [acc | [a, b]])
  def flatten_list_of_tuples([{head} | tail], acc), do: flatten_list_of_tuples(tail, [acc | [head]])
  def flatten_list_of_tuples([], acc), do: List.flatten(acc)
end
