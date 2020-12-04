defmodule Day04 do
  @moduledoc """
  Day 4: Validate passports by the presence of required fields.
  """

  @input_filename "priv/day04/input.txt"

  def run do
    count =
      @input_filename
      |> load_file()
      |> get_valid_passport_count()

    IO.puts("There are #{count} valid passports.")
  end

  def get_valid_passport_count(string) do
    string
    |> get_records()
    |> Enum.map(&parse_record/1)
    |> Enum.filter(&valid_passport?/1)
    |> Enum.count()
  end

  def valid_passport?(%{"byr" => _, "iyr" => _, "eyr" => _, "hgt" => _, "hcl" => _, "ecl" => _, "pid" => _}), do: true
  def valid_passport?(_), do: false

  @doc ~S"""
      iex> Day04.parse_record("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm")
      %{"ecl" => "gry", "pid" => "860033327", "eyr" => "2020", "hcl" => "#fffffd", "byr" => "1937", "iyr" => "2017", "cid" => "147", "hgt" => "183cm"}
  """
  def parse_record(string) do
    string
    |> split_string()
    |> Enum.reduce(%{}, fn data, map ->
      %{"key" => key, "value" => value} = Regex.named_captures(~r/(?<key>[^\:]+)\:(?<value>.+)/, data)
      Map.put(map, key, value)
    end)
  end

  @doc ~S"""
      iex> Day04.split_string("one:1 two:2\tthree:3\nfour:4  five:5")
      ["one:1", "two:2", "three:3", "four:4", "five:5"]
  """
  def split_string(string) do
    String.split(string, ~r/\s/, trim: true)
  end

  def load_file(filename) do
    filename
    |> File.read!()
    |> String.trim()
  end

  def get_records(string) do
    string |> String.split("\n\n")
  end
end
