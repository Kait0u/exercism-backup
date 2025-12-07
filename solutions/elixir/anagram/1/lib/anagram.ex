defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_up = String.upcase(base)

    candidates
    |> Enum.filter(&are_anagrams(base_up, String.upcase(&1)))
  end

  defp are_anagrams(word1, word2)

  defp are_anagrams(word1, word2) when word1 == word2, do: false

  defp are_anagrams(word1, word2) do
    w1_freq = char_frequencies(word1)
    w2_freq = char_frequencies(word2)

    w1_freq == w2_freq
  end

  defp char_frequencies(word), do:
    word
    |> String.to_charlist()
    |> Enum.frequencies()
end
