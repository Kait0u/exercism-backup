defmodule RunLengthEncoder do
  @encode_chain_regex ~r/([a-zA-Z\s])\1*/
  @decode_pair_regex ~r/(\d*)([a-zA-Z\s])/

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.scan(@encode_chain_regex, string)
    |> Enum.map(fn [chain | [captured | _]] ->
      count = String.length(chain)
      count_as_str = if count > 1, do: Integer.to_string(count), else: ""
      "#{count_as_str}#{captured}"
    end)
    |> Enum.join()
  end


  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(@decode_pair_regex, string)
    |> Enum.map(fn [_ | [s_num | [s_ch| _]]] ->
      num = String.to_integer(if s_num == "", do: "1", else: s_num)
      String.duplicate(s_ch, num)
    end)
    |> Enum.join()
  end
end
