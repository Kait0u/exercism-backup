defmodule Pangram do
  @alphabet String.graphemes("abcdefghijklmnopqrstuvwxyz")

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    if String.length(sentence) < length(@alphabet) do
      false
    else
      sentence_graphemes =
      sentence
      |> String.downcase()
      |> String.graphemes()
      |> Enum.dedup()

      @alphabet
      |> Enum.map(&(&1 in sentence_graphemes))
      |> Enum.all?()
    end
  end
end
