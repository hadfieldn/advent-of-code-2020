defmodule Day03BTest do
  use ExUnit.Case
  doctest Day03B

  setup do
    rows = ~w(
      ..##.......
      #...#...#..
      .#....#..#.
      ..#.#...#.#
      .#...##..#.
      ..#.##.....
      .#.#.#....#
      .#........#
      #.##...#...
      #...##....#
      .#..#...#.#
    )

    args_list = [
      [right: 1, down: 1],
      [right: 3, down: 1],
      [right: 5, down: 1],
      [right: 7, down: 1],
      [right: 1, down: 2]
    ]

    %{rows: rows, args_list: args_list}
  end

  describe "traverse_multiple/2" do
    test "gives correct result for sample data", %{rows: rows, args_list: args_list} do
      assert Day03B.traverse_multiple(rows, args_list) == 336
    end
  end
end
