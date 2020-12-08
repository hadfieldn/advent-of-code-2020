defmodule Day07 do
  @moduledoc """
  Day 7: Compute options for holding a certain type of bag.
  """

  @input_filename "priv/day07/input.txt"

  def run do
    count =
      @input_filename
      |> Utils.read_rows()
      |> parse_rules()
      |> options_count_for_bag_color("shiny gold")

    IO.puts("#{inspect(count)} bags can hold a shiny gold bag.")
  end

  def parse_rules(data) do
    data
    |> Enum.map(&parse_rule/1)
    |> Enum.reduce(fn rule, rules_map -> Map.merge(rules_map, rule) end)
  end

  def options_count_for_bag_color(rules, target_color) when is_map(rules) and is_binary(target_color) do
    rules
    |> Enum.count(fn {color, rule} -> rule_contains_color?(rule, target_color, %{rules: rules}) end)
  end

  def rule_contains_color?(rule, _, _) when rule == %{}, do: false

  def rule_contains_color?(rule, target_color, %{rules: rules}) do
    Map.has_key?(rule, target_color) ||
      Enum.any?(rule, fn {color, _count} -> rule_contains_color?(rules[color], target_color, %{rules: rules}) end)
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
