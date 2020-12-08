defmodule Day07Test do
  use ExUnit.Case
  doctest Day07

  @sample_data """
  light red bags contain 1 bright white bag, 2 muted yellow bags.
  dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  bright white bags contain 1 shiny gold bag.
  muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
  shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
  dark olive bags contain 3 faded blue bags, 4 dotted black bags.
  vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
  faded blue bags contain no other bags.
  dotted black bags contain no other bags.
  """

  setup do
    data = String.split(@sample_data, "\n", trim: true)
    rules = Day07.parse_rules(data)
    %{data: data, rules: rules}
  end

  describe "parse_rules/1" do
    test "parses a list of rules", %{data: data} do
      rules = Day07.parse_rules(data)
      assert length(Map.keys(rules)) == length(data)
      assert rules["vibrant plum"] == %{"faded blue" => 5, "dotted black" => 6}
    end
  end

  describe "options_count_for_bag_color/2" do
    test "matches answer provided for sample data", %{rules: rules} do
      assert Day07.options_count_for_bag_color(rules, "shiny gold") == 4
    end
  end

  describe "rule_contains_color?/3" do
    test "resolves rules recursively", %{rules: rules} do
      dark_orange = rules["dark orange"]
      assert Day07.rule_contains_color?(dark_orange, "shiny gold", %{rules: rules}) == true
    end

    test "returns false when rule does not contain color", %{rules: rules} do
      vibrant_plum = rules["vibrant plum"]
      assert Day07.rule_contains_color?(vibrant_plum, "shiny gold", %{rules: rules}) == false
    end
  end
end
