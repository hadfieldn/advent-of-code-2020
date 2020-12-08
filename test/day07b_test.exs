defmodule Day07BTest do
  use ExUnit.Case
  doctest Day07B

  @sample1_data """
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

  @sample2_data """
  shiny gold bags contain 2 dark red bags.
  dark red bags contain 2 dark orange bags.
  dark orange bags contain 2 dark yellow bags.
  dark yellow bags contain 2 dark green bags.
  dark green bags contain 2 dark blue bags.
  dark blue bags contain 2 dark violet bags.
  dark violet bags contain no other bags.
  """
  setup do
    data1 = String.split(@sample1_data, "\n", trim: true)
    rules1 = Day07B.parse_rules(data1)

    data2 = String.split(@sample2_data, "\n", trim: true)
    rules2 = Day07B.parse_rules(data2)
    %{rules1: rules1, rules2: rules2}
  end

  describe "contents_count/2" do
    test "gets correct result for sample 1 data", %{rules1: rules} do
      IO.inspect(rules)
      assert Day07B.contents_count(rules, "shiny gold") - 1 == 32
    end

    test "gets correct result for sample 2 data", %{rules2: rules} do
      IO.inspect(rules)
      assert Day07B.contents_count(rules, "shiny gold") - 1 == 126
    end
  end
end