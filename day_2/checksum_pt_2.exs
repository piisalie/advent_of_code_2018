defmodule SKU do
  def run(list, best_match \\ {"","", 0})
  def run([first | rest], best_match) do
    rest
    |> Enum.reduce(first, &sorter/2)
    |> check(rest, best_match)
  end
  def run([], {sku_1, sku_2, _}) do
    sku_1
    |> String.myers_difference(sku_2)
    |> Keyword.get_values(:eq)
    |> Enum.join
  end

  defp check({_,_, new_distance} = new_match, rest, {_,_, old_distance} ) when new_distance > old_distance do
    run(rest, new_match)
  end
  defp check(_, rest, old_match) do
    run(rest, old_match)
  end

  defp sorter(string, {_, best_match, last_distance} = old_match) do
    distance = String.jaro_distance(string, best_match)

    if distance < 1 && distance > last_distance do
      {string, best_match, distance}
    else
      old_match
    end
  end
  defp sorter(string, first_elm) do
    distance = String.jaro_distance(string, first_elm)

    {string, first_elm, distance}
  end
end

"input.txt"
|> File.read!
|> String.split("\n", trim: true)
|> SKU.run
|> IO.inspect
