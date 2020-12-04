defmodule Day04B do
  @moduledoc """
  Day 4, part 2: Validate passports by the presence and values of required fields.
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

  def valid_passport?(%{"byr" => _, "iyr" => _, "eyr" => _, "hgt" => _, "hcl" => _, "ecl" => _, "pid" => _} = passport) do
    Enum.all?(passport, &valid_field?/1)
  end

  def valid_passport?(_) do
    false
  end

  @doc """
    iex> Day04B.valid_field?({"byr", "2002"})
    true

    iex> Day04B.valid_field?({"byr", "2003"})
    false

    iex> Day04B.valid_field?({"hgt", "60in"})
    true

    iex> Day04B.valid_field?({"hgt", "190cm"})
    true

    iex> Day04B.valid_field?({"hgt", "190in"})
    false

    iex> Day04B.valid_field?({"hgt", "190"})
    false

    iex> Day04B.valid_field?({"hcl", "#123abc"})
    true

    iex> Day04B.valid_field?({"hcl", "#123abz"})
    false

    iex> Day04B.valid_field?({"hcl", "123abc"})
    false

    iex> Day04B.valid_field?({"ecl", "brn"})
    true

    iex> Day04B.valid_field?({"ecl", "wat"})
    false

    iex> Day04B.valid_field?({"pid", "000000001"})
    true

    iex> Day04B.valid_field?({"ecl", "0123456789"})
    false

    iex> Day04B.valid_field?({"cid", "foo"})
    true
  """

  def valid_field?({"byr", byr}) do
    with true <- Regex.match?(~r/^\d{4}$/, byr) do
      year = String.to_integer(byr)
      year >= 1920 and year <= 2002
    end
  end

  def valid_field?({"iyr", iyr}) do
    with true <- Regex.match?(~r/^\d{4}$/, iyr) do
      year = String.to_integer(iyr)
      year >= 2010 and year <= 2020
    end
  end

  def valid_field?({"eyr", eyr}) do
    with true <- Regex.match?(~r/^\d{4}$/, eyr) do
      year = String.to_integer(eyr)
      year >= 2020 and year <= 2030
    end
  end

  def valid_field?({"hgt", hgt}) do
    with %{"height" => height, "unit" => unit} <- Regex.named_captures(~r/^(?<height>\d+)(?<unit>(cm|in))$/, hgt) do
      height = String.to_integer(height)

      case unit do
        "cm" -> height >= 150 and height <= 193
        "in" -> height >= 59 and height <= 76
      end
    else
      _ -> false
    end
  end

  def valid_field?({"hcl", hcl}), do: Regex.match?(~r/^#[0-9a-f]{6}$/, hcl)
  def valid_field?({"ecl", ecl}), do: Regex.match?(~r/^(amb|blu|brn|gry|grn|hzl|oth)$/, ecl)
  def valid_field?({"pid", pid}), do: Regex.match?(~r/^\d{9}$/, pid)
  def valid_field?({"cid", _}), do: true
  def valid_field?(_), do: false

  @doc ~S"""
      iex> Day04.parse_record("ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm")
      %{"ecl" => "gry", "pid" => "860033327", "eyr" => "2020", "hcl" => "#fffffd", "byr" => "1937", "iyr" => "2017", "cid" => "147", "hgt" => "183cm"}
  """
  def parse_record(string) do
    string
    |> split_string()
    |> Enum.reduce(%{}, fn data, map ->
      %{"key" => key, "value" => value} = Regex.named_captures(~r/^(?<key>[^\:]+)\:(?<value>.+)$/, data)
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
