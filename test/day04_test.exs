defmodule Day04Test do
  use ExUnit.Case
  doctest Day04

  describe "read_records/1" do
    test "splits records on empty newlines" do
      string = """
      byr:1985
      eyr:2021 iyr:2011 hgt:175cm pid:163069444 hcl:#18171d

      eyr:2023
      hcl:#cfa07d ecl:blu hgt:169cm pid:494407412 byr:1936

      ecl:zzz
      eyr:2036 hgt:109 hcl:#623a2f iyr:1997 byr:2029
      cid:169 pid:170290956
      """

      records = Day04.get_records(string)
      assert length(records) == 3
    end
  end

  describe "get_valid_passport_count/1" do
    test "gets correct results with sample data" do
      data = ~S"""
      ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
      byr:1937 iyr:2017 cid:147 hgt:183cm

      iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
      hcl:#cfa07d byr:1929

      hcl:#ae17e1 iyr:2013
      eyr:2024
      ecl:brn pid:760753108 byr:1931
      hgt:179cm

      hcl:#cfa07d eyr:2025 pid:166559648
      iyr:2011 ecl:brn hgt:59in
      """

      assert Day04.get_valid_passport_count(data) == 2
    end
  end
end
