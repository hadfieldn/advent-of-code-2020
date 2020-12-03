defmodule Day02B do
  @moduledoc """
  Day 1: Given a list of passwords, identify how many are valid.

  Password format: <n>-<m> <a>: <password>
  `password` must contain one and only one `a` in positions `n` and `m` (1-based).
  """

  @input_filename "priv/day02/input.txt"

  def run do
    count = parsed_rows(@input_filename) |> Enum.count(&valid?/1)

    IO.puts("There are #{count} valid passwords.")
  end

  @doc """
  ## Examples

    iex> Day02B.valid?(%{"pos1" => 1, "pos2" => 3, "letter" => "a", "password" => "abcde"})
    true

    iex> Day02B.valid?(%{"pos1" => 1, "pos2" => 3, "letter" => "b", "password" => "cdefg"})
    false

    iex> Day02B.valid?(%{"pos1" => 2, "pos2" => 9, "letter" => "c", "password" => "ccccccccc"})
    false
  """
  def valid?(%{"pos1" => pos1, "pos2" => pos2, "letter" => letter, "password" => password}) do
    graphemes = String.graphemes(password)
    letter1 = Enum.at(graphemes, pos1 - 1)
    letter2 = Enum.at(graphemes, pos2 - 1)

    (letter1 == letter && letter2 != letter) || (letter1 != letter && letter2 == letter)
  end

  def parsed_rows(filename) do
    filename
    |> Utils.read_rows()
    |> Enum.map(&parsed_row/1)
  end

  @doc """
  Parsed password row

  ## Examples

      iex> Day02B.parsed_row("1-3 a: abcde")
      %{"pos1" => 1, "pos2" => 3, "letter" => "a", "password" => "abcde"}
  """
  def parsed_row(row) do
    captures = Regex.named_captures(~r/(?<pos1>\d+)\-(?<pos2>\d+) (?<letter>\S)\: (?<password>\S+)/, row)

    captures
    |> Map.put("pos1", String.to_integer(captures["pos1"]))
    |> Map.put("pos2", String.to_integer(captures["pos2"]))
  end
end
