defmodule PigLatin do
  @vowels ["a", "e", "u", "i", "o"]

  @init_consonant_regex ~r/^([b-df-hj-np-tv-z]+)/i
  @init_consonant_qu_regex ~r/^([b-df-hj-np-tv-z]*qu)/i
  @init_consonant_y_regex ~r/^([b-df-hj-np-tv-z]+)y/i

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&translate_word/1)
    |> Enum.join(" ")
  end

  defp translate_word(word) do
    [&rule1/1, &rule4/1, &rule3/1, &rule2/1] # Such order of rules is necessary.
    |> Enum.reduce_while(word, fn rule, _ ->
      new_word = rule.(word)
        if new_word != word do
          {:halt, new_word}
        else
          {:cont, word}
        end
      end)
  end

  # If a word begins with a vowel, or starts with "xr" or "yt", add an "ay" sound to the end of the word.
  defp rule1(word) do
    prefixes = ["xr" | ["yt" | @vowels]]

    if String.starts_with?(word, prefixes) do
      "#{word}ay"
    else
      word
    end
  end

  # If a word begins with one or more consonants, first move those consonants to the end of the word and then add an "ay" sound to the end of the word.
  defp rule2(word) do
    case Regex.run(@init_consonant_regex, word) do
      [caught | _] ->
        rest = String.replace_prefix(word, caught, "")
        "#{rest}#{caught}ay"
      _ -> word
    end
  end

  # If a word starts with zero or more consonants followed by "qu", first move those consonants (if any) and the "qu" part to the end of the word,
  # and then add an "ay" sound to the end of the word.
  defp rule3(word) do
    case Regex.run(@init_consonant_qu_regex, word) do
      [caught | _] ->
        rest = String.replace_prefix(word, caught, "")
        "#{rest}#{caught}ay"
      _ -> word
    end
  end

  # If a word starts with one or more consonants followed by "y", first move the consonants preceding the "y"to the end of the word,
  # and then add an "ay" sound to the end of the word.
  defp rule4(word) do
    case Regex.run(@init_consonant_y_regex, word) do
      [_ | [caught | _]] ->
        rest = String.replace_prefix(word, caught, "")
        "#{rest}#{caught}ay"
      _ -> word
    end
  end
end
