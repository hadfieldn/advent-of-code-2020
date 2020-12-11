defmodule Day11BTest do
  use ExUnit.Case
  doctest Day11B

  @sample_data ~w(
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
  )

  test "gets answer provided for sample data" do
    result =
      @sample_data
      |> Day11B.get_layout()
      |> Day11B.iterate_to_convergence()

    assert %{occupancy: 26} = result
  end

  test "update_seating/1" do
    start_data = ~w(
      #.LL.LL.L#
      #LLLLLL.LL
      L.L.L..L..
      LLLL.LL.LL
      L.LL.LL.LL
      L.LLLLL.LL
      ..L.L.....
      LLLLLLLLL#
      #.LLLLLL.L
      #.LLLLL.L#
    )

    expected =
      ~w(
      #.L#.##.L#
      #L#####.LL
      L.#.#..#..
      ##L#.##.##
      #.##.#L.##
      #.#####.#L
      ..#.#.....
      LLL####LL#
      #.L#####.L
      #.L####.L#
    )
      |> Day11B.get_layout()

    actual =
      start_data
      |> Day11B.get_layout()
      |> Day11B.update_seating()

    assert expected == actual
  end

  test "adjacent_occupancy/1" do
    data = ~w(
      .......#.
      ...#.....
      .#.......
      .........
      ..#L....#
      ....#....
      .........
      #........
      ...#.....
    )
    %{grid: grid} = Day11B.get_layout(data)
    assert Day11B.adjacent_occupancy({4, 3}, grid) == 8
  end
end
