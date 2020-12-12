defmodule Day12B do
  @moduledoc """
  Day 12, part 2: Calculate the manhattan distance traveled using a waypoint.
  """

  @input_filename "priv/day12/input.txt"
  @initial_state %{x: 0, y: 0, wx: 10, wy: 1}

  def run() do
    %{x: x, y: y} =
      @input_filename
      |> Utils.read_rows()
      |> get_commands()
      |> travel()

    distance = abs(x) + abs(y)
    IO.puts("Distance is #{x} + #{y} = #{distance}")
  end

  @doc """
    iex> ["F10", "N3", "F7", "R90", "F11"] |> Day12B.get_commands() |> Day12B.travel()
    %{x: 214, y: -72, wx: 4, wy: -10}
  """
  def travel(commands, state \\ @initial_state)
  def travel([], state), do: state

  def travel([command | rest], %{x: x, y: y, wx: wx, wy: wy} = state) do
    next_state =
      case command do
        {"N", arg} -> %{state | wy: wy + arg}
        {"S", arg} -> %{state | wy: wy - arg}
        {"W", arg} -> %{state | wx: wx - arg}
        {"E", arg} -> %{state | wx: wx + arg}
        {"L", arg} -> rotate_waypoint(-arg, state)
        {"R", arg} -> rotate_waypoint(arg, state)
        {"F", arg} -> %{state | x: x + arg * wx, y: y + arg * wy}
      end

    travel(rest, next_state)
  end

  @doc """
    Rotate the ship clockwise the given number of degrees.

    iex> Day12B.rotate_waypoint(0, %{wx: 10, wy: 4})
    %{wx: 10, wy: 4}

    iex> Day12B.rotate_waypoint(90, %{wx: 10, wy: 4})
    %{wx: 4, wy: -10}

    iex> Day12B.rotate_waypoint(180, %{wx: 10, wy: 4})
    %{wx: -10, wy: -4}

    iex> Day12B.rotate_waypoint(270, %{wx: 10, wy: 4})
    %{wx: -4, wy: 10}

    iex> Day12B.rotate_waypoint(-90, %{wx: 10, wy: 4})
    %{wx: -4, wy: 10}
  """
  def rotate_waypoint(degrees, %{wx: wx, wy: wy} = state) do
    case rem(-1 * degrees + 360, 360) do
      0 -> state
      90 -> %{state | wx: -wy, wy: wx}
      180 -> %{state | wx: -wx, wy: -wy}
      270 -> %{state | wx: wy, wy: -wx}
    end
  end

  @doc """
    iex> Day12B.get_commands(["F10", "N3", "F7", "R90", "F11"])
    [{"F", 10}, {"N", 3}, {"F", 7}, {"R", 90}, {"F", 11}]
  """
  def get_commands(data) do
    for line <- data do
      %{"command" => command, "arg" => arg} = Regex.named_captures(~r/(?<command>\S)(?<arg>\d+)/, line)
      {command, String.to_integer(arg)}
    end
  end
end
