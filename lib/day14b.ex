defmodule Day14B do
  @moduledoc """
  Day 14, part 2: Memory address bitmask
  """

  @input_filename "priv/day14/input.txt"
  @initial_state %{mem: %{}, mask: ""}

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
    %{state | mask: mask}
  end

  def execute_line("mem" <> _ = line, %{mem: mem, mask: mask} = state) do
    %{"address" => address_string, "value" => value} =
      Regex.named_captures(~r/mem\[(?<address>\d+)\] = (?<value>\d+)/, line)

    value = String.to_integer(value)

    mem =
      address_string
      |> String.to_integer()
      |> get_masked_address_string(mask)
      |> get_floating_addresses()
      |> Enum.map(&String.to_integer(&1, 2))
      |> Enum.reduce(mem, fn address, mem ->
        Map.put(mem, address, value)
      end)

    %{state | mem: mem}
  end

  @doc """
    iex> Day14B.get_masked_address_string(42, "0X1001X")
    "0X1101X"
  """
  def get_masked_address_string(address, mask) do
    address_string =
      address
      |> Integer.to_string(2)
      |> String.pad_leading(String.length(mask), "0")

    for i <- 0..(String.length(mask) - 1) do
      case String.at(mask, i) do
        "0" -> String.at(address_string, i)
        char -> char
      end
    end
    |> List.to_string()
  end

  @doc """
    iex> Day14B.get_floating_addresses("0X1001X")
    ["0010010", "0010011", "0110010", "0110011"]
  """

  def get_floating_addresses(""), do: [""]

  def get_floating_addresses("X" <> rest) do
    for value <- ["0", "1"] do
      get_floating_addresses(rest)
      |> Enum.map(&(value <> &1))
    end
    |> List.flatten()
  end

  def get_floating_addresses(<<head::binary-size(1)>> <> rest) do
    get_floating_addresses(rest) |> Enum.map(&(head <> &1))
  end
end
