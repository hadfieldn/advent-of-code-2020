defmodule Day07B do
  @moduledoc """
  Day 7, part 2: Compute number of bags contained within a given bag.
  """

  @input_filename "priv/day07/input.txt"

  def run do
    count =
      @input_filename
      |> Utils.read_rows()
      |> parse_rules()
      |> contents_count("shiny gold")

    IO.puts("A shiny gold back contains #{inspect(count - 1)} bags inside.")
  end

  def parse_rules(data) do
    data
    |> Enum.map(&parse_rule/1)
    |> Enum.reduce(fn rule, rules_map -> Map.merge(rules_map, rule) end)
  end

  @doc """
  Returns count of containers for a given color, including the enclosing container for that color.
  (To get only the number of containers inside, need to subtract 1 from the result.)
  """
  def contents_count(rules, target_color) when is_map(rules) and is_binary(target_color) do
    rule = rules[target_color]

    if rule == %{} do
      1
    else
      1 +
        Enum.reduce(rule, 0, fn
          {color, count}, total ->
            total + count * contents_count(rules, color)
        end)
    end
  end

  @doc """
    iex> Day07.parse_rule("light red bags contain 1 bright white bag, 2 muted yellow bags.")
    %{"light red" => %{"bright white" => 1, "muted yellow" => 2}}
  """
  def parse_rule(rule) do
    %{"color" => color, "contents" => contents} =
      Regex.named_captures(~r/(?<color>.*) bags contain (?<contents>.*)\./, rule)

    parsed_contents =
      contents
      |> String.split(", ", trim: true)
      |> Enum.reduce(%{}, fn value, map -> Map.merge(map, parse_content_value(value)) end)

    %{color => parsed_contents}
  end

  @doc """
    iex> Day07.parse_content_value("no other bags")
    %{}

    iex> Day07.parse_content_value("1 bright white bag")
    %{"bright white" => 1}

    iex> Day07.parse_content_value("2 muted yellow bags")
    %{"muted yellow" => 2}
  """
  def parse_content_value("no other bags"), do: %{}

  def parse_content_value(value) do
    %{"count" => count, "color" => color} = Regex.named_captures(~r/(?<count>\d+) (?<color>.+) bags?/, value)
    %{color => String.to_integer(count)}
  end
end
