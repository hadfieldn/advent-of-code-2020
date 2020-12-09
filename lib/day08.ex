defmodule Day08 do
  @moduledoc """
  Day 8: Find infinite loop.
  """

  @input_filename "priv/day08/input.txt"
  @initial_state %{acc: 0, ptr: 0, visited: MapSet.new()}

  def run do
    %{acc: acc} =
      @input_filename
      |> Utils.read_rows()
      |> parse_code()
      |> execute_code()

    IO.puts("Accumulator: #{acc}")
  end

  def execute_code(code, %{visited: visited, ptr: ptr} = state \\ @initial_state) do
    if not MapSet.member?(visited, ptr) do
      instr = Enum.at(code, ptr)
      state = execute(instr, state)
      state = %{state | visited: MapSet.put(visited, ptr)}
      #      IO.inspect(%{instr: instr, state: state})
      execute_code(code, state)
    else
      state
    end
  end

  def execute({"acc", arg}, %{acc: acc, ptr: ptr} = state), do: %{state | acc: acc + arg, ptr: ptr + 1}
  def execute({"jmp", arg}, %{ptr: ptr} = state), do: %{state | ptr: ptr + arg}
  def execute({"nop", _arg}, %{ptr: ptr} = state), do: %{state | ptr: ptr + 1}

  def parse_code(data) when is_binary(data) do
    data
    |> String.split("\n", trim: true)
    |> parse_code()
  end

  def parse_code(data) when is_list(data) do
    Enum.map(data, &parse_line/1)
  end

  @doc """
    iex> Day08.parse_line("nop +0")
    {"nop", 0}
    iex> Day08.parse_line("acc -99")
    {"acc", -99}
    iex> Day08.parse_line("jmp +4")
    {"jmp", 4}
  """
  def parse_line(line) do
    %{"op" => op, "arg" => arg} = Regex.named_captures(~r/(?<op>(acc|jmp|nop)) (?<arg>[+\-]\d+)/, line)
    {op, String.to_integer(arg)}
  end
end
