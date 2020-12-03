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
      _ -> IO.puts("Not yet implemented.")
    end
  end
end
