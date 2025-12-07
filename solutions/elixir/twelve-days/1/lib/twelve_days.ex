defmodule TwelveDays do
  @day_to_gift %{
    12 => "twelve Drummers Drumming",
    11 => "eleven Pipers Piping",
    10 => "ten Lords-a-Leaping",
    9  => "nine Ladies Dancing",
    8  => "eight Maids-a-Milking",
    7  => "seven Swans-a-Swimming",
    6  => "six Geese-a-Laying",
    5  => "five Gold Rings",
    4  => "four Calling Birds",
    3  => "three French Hens",
    2  => "two Turtle Doves",
    1  => "a Partridge in a Pear Tree"
  }

  @day_to_ordinal %{
    12 => "twelfth",
    11 => "eleventh",
    10 => "tenth",
    9  => "ninth",
    8  => "eighth",
    7  => "seventh",
    6  => "sixth",
    5  => "fifth",
    4  => "fourth",
    3  => "third",
    2  => "second",
    1  => "first"
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    days_ordinal = @day_to_ordinal[number]

    days_gifts = day_gifts(number)
    gifts_clause = build_gifts_clause(days_gifts)

    "On the #{days_ordinal} day of Christmas my true love gave to me: #{gifts_clause}."
  end

  defp day_gifts(number) do
    1 .. number
    |> Enum.reduce([], fn day, gifts ->
      gift = @day_to_gift[day]

      [gift | gifts]
    end)
  end

  defp build_gifts_clause([gift | []]), do: gift

  defp build_gifts_clause(gifts) do
    gift_count = length(gifts)

    gifts
    |> Enum.zip(1 .. gift_count)
    |> Enum.map(fn {gift, num} ->
      if num == gift_count do
        "and #{gift}"
      else
        gift
      end
    end)
    |> Enum.join(", ")
    |> String.trim()
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse .. ending_verse
    |> Enum.map(&verse(&1))
    |> Enum.join("\n")
    |> String.trim()
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end
end
