defmodule Day10B do
  @moduledoc """
  Day 10: Find differences in adapters.
  """

  @input_filename "priv/day10/input.txt"

  def run() do
    count =
      @input_filename
      |> Utils.read_rows()
      |> get_tree()
      |> leaf_count()

    IO.puts("Number of ways to arrange the adapters: #{count}")
  end

  @doc """
  Keeps a map of counts for each node so that we don't have to repeat calculations for nodes we've already visited.
  We visit children in depth-first reverse order, because the path through a given child will be a superset of the
  path through any of its higher-numbered siblings. The shortest path will be the path through highest-numbered
  children; the next path will be that shortest path plus an additional node. As we move toward lower-numbered paths,
  each sibling will be a subtree that is the subtree rooted by its next-older older sibling, plus itself.

  As we move back up the tree in our depth-first (reverse) traversal, next-lower siblings will not have to recurse
  through their subtrees because those subtrees will already have been computed, except for at most two child nodes
  that were skipped by the higher-sibling's path. But the subtrees rooted in those nodes will already have been
  computed.

  iex> Day10B.leaf_count(%{0 => [1]})
  1
  iex> Day10B.leaf_count(%{0 => [1], 1 => [4], 4 => [5, 6, 7]})
  3
  iex> Day10B.leaf_count(%{0 => [1], 1 => [4], 4 => [5, 6, 7], 5 => [6, 7], 6 => [7], 7 => [10], 10 => [11, 12], 11 => [12], 12 => [15], 15 => [16], 16 => [19], 19 => [22]})
  8
  """
  def leaf_count(tree) do
    %{counts: counts} = leaf_count(0, %{tree: tree, counts: %{}})
    counts[0]
  end

  def leaf_count(node, %{tree: tree, counts: counts} = state) do
    tree[node]
    |> Enum.reverse()
    |> Enum.reduce({0, state}, fn child, {total, state} ->
      state =
        cond do
          counts[child] == nil && tree[child] == nil -> %{state | counts: Map.put(counts, child, 1)}
          counts[child] == nil -> leaf_count(child, state)
          true -> state
        end

      {total + state.counts[child], state}
    end)
    |> case do
      {total, state} -> %{state | counts: Map.put(counts, node, total)}
    end
  end

  @doc """
    iex> numbers = "16 10 15 5 1 11 7 19 6 12 4" |> String.split(" ")
    ...> Day10B.get_tree(numbers)
    %{0 => [1], 1 => [4], 4 => [5, 6, 7], 5 => [6, 7], 6 => [7], 7 => [10], 10 => [11, 12], 11 => [12], 12 => [15], 15 => [16], 16 => [19], 19 => [22]}
  """
  def get_tree(numbers) do
    numbers
    |> Enum.map(&String.to_integer/1)
    |> case do
      numbers -> [0 | numbers] ++ [Enum.max(numbers) + 3]
    end
    |> Enum.sort()
    |> case do
      numbers -> get_tree(%{}, numbers)
    end
  end

  def get_tree(tree, [current, a, b]) do
    tree
    |> set_node(current, [a, b])
    |> set_node(a, [b])
  end

  def get_tree(tree, [current, a, b, c | rest]) do
    tree
    |> set_node(current, [a, b, c])
    |> get_tree([a, b, c | rest])
  end

  def set_node(tree, current, next_three_or_fewer) do
    valid_edges = next_three_or_fewer |> Enum.filter(&(&1 - current <= 3))
    Map.put(tree, current, valid_edges)
  end
end
