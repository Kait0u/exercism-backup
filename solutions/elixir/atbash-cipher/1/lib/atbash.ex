defmodule Atbash do
  @alphabet "abcdefghijklmnopqrstuvwxyz"
  @key String.reverse(@alphabet)

  @group_size 5
  @group_separator " "

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    encoding_map = encoding_map(@alphabet, @key)
    grouping_stream = grouping_stream()

    plaintext
    |> String.downcase()
    |> String.replace(~r/[^\d\w]/, "")
    |> String.graphemes()
    |> Enum.map(&(Map.get(encoding_map, &1, &1)))
    |> Enum.zip(grouping_stream)
    |> Enum.group_by(fn {_, num} -> num end, fn {ch, _} -> ch end)
    |> Enum.to_list()
    |> Enum.sort_by(fn {group_no, _} -> group_no end)
    |> Enum.map(fn {_, group} -> group end)
    |> Enum.map(fn group -> Enum.join(group) end)
    |> Enum.join(@group_separator)
    |> String.trim()
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    encoding_map = encoding_map(@key, @alphabet)

    cipher
    |> String.downcase()
    |> String.replace(~r/\s/, "")
    |> String.graphemes()
    |> Enum.map(&(Map.get(encoding_map, &1, &1)))
    |> Enum.join()
  end

  defp encoding_map(input_alphabet, output_alphabet) do
    in_list = String.graphemes(input_alphabet)
    out_list = String.graphemes(output_alphabet)

    Enum.zip(in_list, out_list)
    |> Map.new()
  end

  defp grouping_stream() do
    Stream.resource(
      fn -> {1, 1} end,
      fn {n, rep} ->
        cond do
          rep < @group_size -> {[n], {n, rep + 1}}
          true -> {[n], {n + 1, 1}}
        end
      end,
      fn _ -> :ok end
    )
  end

end
