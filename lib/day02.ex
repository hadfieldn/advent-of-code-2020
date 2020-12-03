defmodule Day02 do
  @moduledoc """
  Day 2: Given a list of passwords, identify how many are valid.

  Password format: <n>-<m> <a>: <password>
  `password` must contain minimum `n` and maximum `m` occurrences of `a`.
  """

  @input_filename "priv/day02/input.txt"

  def run do
    count = parsed_rows(@input_filename) |> Enum.count(&valid?/1)

    IO.puts("There are #{count} valid passwords.")
  end

  @doc """
  ## Examples

    iex> Day02.valid?(%{"min" => 1, "max" => 3, "letter" => "a", "password" => "abcde"})
    true

    iex> Day02.valid?(%{"min" => 1, "max" => 3, "letter" => "b", "password" => "cdefg"})
    false

    iex> Day02.valid?(%{"min" => 2, "max" => 9, "letter" => "c", "password" => "ccccccccc"})
    true
  """
  def valid?(%{"min" => min, "max" => max, "letter" => letter, "password" => password}) do
    regex = Regex.compile!(letter)
    count = Regex.scan(regex, password) |> Enum.count()

    count >= min and count <= max
  end

  def parsed_rows(filename) do
    filename
    |> Utils.read_rows()
    |> Enum.map(&parsed_row/1)
  end

  @doc """
  Parsed password row

  ## Examples

      iex> Day02.parsed_row("1-3 a: abcde")
      %{"min" => 1, "max" => 3, "letter" => "a", "password" => "abcde"}
  """
  def parsed_row(row) do
    captures = Regex.named_captures(~r/(?<min>\d+)\-(?<max>\d+) (?<letter>\S)\: (?<password>\S+)/, row)

    captures
    |> Map.put("min", String.to_integer(captures["min"]))
    |> Map.put("max", String.to_integer(captures["max"]))
  end
end
