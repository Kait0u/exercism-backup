defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(&evaluate/1)
    |> Enum.sum()
  end

  def evaluate(character) do
    cond do
      character in ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"] -> 1
      character in ["D", "G"] -> 2
      character in ["B", "C", "M", "P"] -> 3
      character in ["F", "H", "V", "W", "Y"] -> 4
      character in ["K"] -> 5
      character in ["J", "X"] -> 8
      character in ["Q", "Z"] -> 10
      true -> 0
    end
  end
end
