defmodule Day14 do
  @moduledoc """
  Day 14: Value bitmask
  """

  @input_filename "priv/day14/input.txt"
  @initial_state %{mem: %{}, mask: %{and: 0, or: 0}}

  require Bitwise

  def run() do
    %{mem: mem} =
      @input_filename
      |> Utils.read_rows()
      |> execute()

    sum = mem |> Map.values() |> Enum.sum()
    IO.puts("The sum of values in memory is #{sum}")
  end

  def execute(lines, state \\ @initial_state)
  def execute([], state), do: state

  def execute([line | rest], state) do
    new_state = execute_line(line, state)
    execute(rest, new_state)
  end

  def execute_line("mask = " <> mask, state) do
    or_mask = mask |> String.replace("X", "0") |> String.to_integer(2)
    and_mask = mask |> String.replace("X", "1") |> String.to_integer(2)
    %{state | mask: %{or: or_mask, and: and_mask}}
  end

  def execute_line("mem" <> _ = line, %{mem: mem, mask: %{or: or_mask, and: and_mask}} = state) do
    %{"address" => address, "value" => value} = Regex.named_captures(~r/mem\[(?<address>\d+)\] = (?<value>\d+)/, line)
    address = address |> String.to_integer()
    value = value |> String.to_integer() |> Bitwise.|||(or_mask) |> Bitwise.&&&(and_mask)
    mem = Map.put(mem, address, value)
    %{state | mem: mem}
  end
end
