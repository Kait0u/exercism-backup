defmodule DNA do
  @code_size 4

  @acid_to_code_map %{
    ?\s => 0b0000,
    ?A  => 0b0001,
    ?C  => 0b0010,
    ?G  => 0b0100,
    ?T  => 0b1000
  }

  @code_to_acid_map @acid_to_code_map
  |> Enum.map(fn {k, v} -> {v, k} end)
  |> Enum.into(%{})


  def encode_nucleotide(code_point) do
    @acid_to_code_map[code_point]
  end

  def decode_nucleotide(encoded_code) do
    @code_to_acid_map[encoded_code]
  end

  def encode(dna) do
    dna
    |> Enum.map(&encode_nucleotide/1)
    |> Enum.reduce(<<>>, fn code, acc -> <<acc::bitstring, code::size(@code_size)>> end)
  end

  def decode(dna) do
    do_decode(dna, ~c"")
  end

  defp do_decode(<<>>, acc), do: acc
  defp do_decode(<<curr_code::size(@code_size), remainder::bitstring>>, acc) do
    acc = acc ++ [decode_nucleotide(curr_code)]
    do_decode(remainder, acc)
  end
end
