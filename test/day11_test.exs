defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

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
      |> Day11.get_layout()
      |> Day11.iterate_to_convergence()

    assert %{occupancy: 37} = result
  end

  test "update_seating/1" do
    expected =
      ~w(
      #.##.##.##
      #######.##
      #.#.#..#..
      ####.##.##
      #.##.##.##
      #.#####.##
      ..#.#.....
      ##########
      #.######.#
      #.#####.##
    )
      |> Day11.get_layout()

    actual =
      @sample_data
      |> Day11.get_layout()
      |> Day11.update_seating()

    assert expected == actual
  end

  test "adjacent_occupancy/1" do
    data = ~w(
      #.##.##.##
      #######.##
      #.#.#..#..
      ####.##.##
      #.##.##.##
      #.#####.##
      ..#.#.....
      ##########
      #.######.#
      #.#####.##
    )
    %{grid: grid} = Day11.get_layout(data)
    assert Day11.adjacent_occupancy({0, 6}, grid) == 3
  end
end
