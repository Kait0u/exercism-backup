defmodule WordCount do
  @word_regex ~r/\b([0-9A-Z']+)\b|\b([0-9A-Z]+)|([0-9A-Z]+)\b/iu

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> (fn s -> (Regex.scan(@word_regex, s)) end).()
    |> Enum.map(fn [w | _] -> String.downcase(w) end)
    |> Enum.frequencies()
  end
end
