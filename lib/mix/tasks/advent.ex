defmodule Mix.Tasks.Advent do
  use Mix.Task

  @impl Mix.Task
  def run(args) do
    [day] = args

    case day do
      "01" -> Day01.run()
      "01b" -> Day01B.run()
      "02" -> Day02.run()
      "02b" -> Day02B.run()
      "03" -> Day03.run()
      "03b" -> Day03B.run()
      "04" -> Day04.run()
      "04b" -> Day04B.run()
      "05" -> Day05.run()
      "05b" -> Day05B.run()
      "06" -> Day06.run()
      "06b" -> Day06B.run()
      "07" -> Day07.run()
      "07b" -> Day07B.run()
      "08" -> Day08.run()
      "08b" -> Day08B.run()
      "09" -> Day09.run()
      "09b" -> Day09B.run()
      "10" -> Day10.run()
      "10b" -> Day10B.run()
      "11" -> Day11.run()
      "11b" -> Day11B.run()
      _ -> IO.puts("Not yet implemented.")
    end
  end
end
