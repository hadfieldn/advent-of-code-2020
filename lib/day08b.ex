defmodule Day08B do
  @moduledoc """
  Day 8: Fix the infinite loop.
  """

  @input_filename "priv/day08/input.txt"
  @initial_state %{acc: 0, ptr: 0, visited: MapSet.new()}

  def run do
    {:ok, %{acc: acc, fixed_line: fixed_line}} =
      @input_filename
      |> Utils.read_rows()
      |> parse_code()
      |> fix_code()

    IO.puts("Accumulator after fixing line #{fixed_line + 1}: #{acc}")
  end

  def fix_code(code, fix_line \\ 0) do
    new_line =
      case Enum.at(code, fix_line) do
        {"jmp", arg} -> {"nop", arg}
        {"nop", arg} -> {"jmp", arg}
        line -> line
      end

    fixed_code = List.replace_at(code, fix_line, new_line)

    case execute_code(fixed_code) do
      {:ok, state} ->
        {:ok, Map.put(state, :fixed_line, fix_line)}

      {:error, :infinite_loop, state} ->
        if fix_line < Enum.count(code) - 1 do
          fix_code(code, fix_line + 1)
        else
          {:error, :unfixable, state}
        end
    end
  end

  def execute_code(code, %{visited: visited, ptr: ptr} = state \\ @initial_state) do
    cond do
      ptr >= Enum.count(code) ->
        {:ok, state}

      not MapSet.member?(visited, ptr) ->
        state = execute_next_line(code, state)
        execute_code(code, state)

      true ->
        {:error, :infinite_loop, state}
    end
  end

  def execute_next_line(code, %{visited: visited, ptr: ptr} = state) do
    state = execute(Enum.at(code, ptr), state)
    %{state | visited: MapSet.put(visited, ptr)}
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
