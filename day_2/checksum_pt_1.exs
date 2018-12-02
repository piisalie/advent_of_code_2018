defmodule Checksum do
  def compute(string, accumulator) do
    string
    |> String.split("", trim: true)
    |> Enum.sort
    |> Enum.chunk_by(fn letter -> letter end)
    |> Enum.group_by(&length/1)
    |> update_accumulator(accumulator)
  end

  defp update_accumulator(%{2 => _, 3 => _}, {two_accumulator, three_accumulator}) do
    {two_accumulator + 1, three_accumulator + 1}
  end
  defp update_accumulator(%{2 => _}, {two_accumulator, three_accumulator}) do
    {two_accumulator + 1, three_accumulator}
  end
  defp update_accumulator(%{3 => _}, {two_accumulator, three_accumulator}) do
    {two_accumulator, three_accumulator + 1}
  end
  defp update_accumulator(_, accumulator) do
    accumulator
  end
end

{twos_count, threes_count} =
  "input.txt"
  |> File.read!
  |> String.split("\n", trim: true)
  |> Enum.reduce({0, 0}, &Checksum.compute/2)

twos_count * threes_count |> IO.inspect
