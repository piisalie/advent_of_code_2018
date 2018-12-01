defmodule FrequencyFinder do
  def update_frequency(["+" | rest ], accumulator) do
    accumulator + parse_number(rest)
  end
  def update_frequency(["-" | rest ], accumulator) do
    accumulator - parse_number(rest)
  end

  defp parse_number(list) do
    list
    |> Enum.join
    |> String.to_integer
  end
end

"input.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Enum.reduce(0, &FrequencyFinder.update_frequency/2)
|> IO.inspect
