defmodule Day12 do
  @moduledoc """
  Day 12: Calculate the manhattan distance traveled.
  """

  @input_filename "priv/day12/input.txt"
  @initial_state %{x: 0, y: 0, heading: 0}

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
    iex> ["F10", "N3", "F7", "R90", "F11"] |> Day12.get_commands() |> Day12.travel()
    %{x: 17, y: -8, heading: 270}
  """
  def travel(commands, state \\ @initial_state)
  def travel([], state), do: state

  def travel([command | rest], %{x: x, y: y, heading: heading} = state) do
    next_state =
      case command do
        {"N", arg} -> %{state | y: y + arg}
        {"S", arg} -> %{state | y: y - arg}
        {"W", arg} -> %{state | x: x - arg}
        {"E", arg} -> %{state | x: x + arg}
        {"L", arg} -> %{state | heading: new_heading(heading, arg)}
        {"R", arg} -> %{state | heading: new_heading(heading, -arg)}
        {"F", arg} -> move_forward(arg, state)
      end

    travel(rest, next_state)
  end

  def move_forward(distance, %{x: x, y: y, heading: heading} = state) do
    case heading do
      0 -> %{state | x: x + distance}
      90 -> %{state | y: y + distance}
      180 -> %{state | x: x - distance}
      270 -> %{state | y: y - distance}
    end
  end

  @doc """
    iex> Day12.new_heading(0, -90)
    270

    iex> Day12.new_heading(90, 90)
    180

    iex> Day12.new_heading(270, 180)
    90
  """
  def new_heading(current_heading, delta) do
    case current_heading + delta do
      heading when heading < 0 -> heading + 360
      heading when heading >= 360 -> heading - 360
      heading -> heading
    end
  end

  @doc """
    iex> Day12.get_commands(["F10", "N3", "F7", "R90", "F11"])
    [{"F", 10}, {"N", 3}, {"F", 7}, {"R", 90}, {"F", 11}]
  """
  def get_commands(data) do
    for line <- data do
      %{"command" => command, "arg" => arg} = Regex.named_captures(~r/(?<command>\S)(?<arg>\d+)/, line)
      {command, String.to_integer(arg)}
    end
  end
end
