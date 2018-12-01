defmodule FrequencyFinder do
  def update_frequency(["+" | rest ], [last_freq | _ ] = accumulator) do
    last_freq
    |> Kernel.+(parse_number(rest))
    |> handle_result(accumulator)
  end
  def update_frequency(["-" | rest ], [last_freq | _ ] = accumulator) do
    last_freq
    |> Kernel.-(parse_number(rest))
    |> handle_result(accumulator)
  end

  defp parse_number(list) do
    list
    |> Enum.join
    |> String.to_integer
  end

  defp handle_result(new_freq, accumulator) do
    if new_freq in accumulator do
      {:halt, [new_freq |accumulator ]}
    else
      {:cont, [new_freq | accumulator]}
    end
  end
end

"input.txt"
|> File.read!
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Stream.cycle
|> Enum.reduce_while([0], &FrequencyFinder.update_frequency/2)
|> hd
|> IO.inspect
