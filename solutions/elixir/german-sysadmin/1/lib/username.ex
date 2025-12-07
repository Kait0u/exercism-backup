defmodule Username do
  @lowercase_letters ?a..?z

  def sanitize([]), do: []

  def sanitize([first_char | tail]) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    result = case first_char do
      ?ä -> ~c"ae"
      ?ö -> ~c"oe"
      ?ü -> ~c"ue"
      ?ß -> ~c"ss"
      ?_ -> ~c"_"
      first_char when first_char in @lowercase_letters -> [first_char]
      _ -> []
    end

    result ++ sanitize(tail)
  end
end
