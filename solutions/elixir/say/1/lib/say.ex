defmodule Say do
  @doc """
  Translate a positive integer into English.
  """

  @dictionary %{
     1 => "one",
     2 => "two",
     3 => "three",
     4 => "four",
     5 => "five",
     6 => "six",
     7 => "seven",
     8 => "eight",
     9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @billion 1_000_000_000
  @million 1_000_000
  @thousand 1_000
  @one 1

  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0 or 999_999_999_999 < number, do: {:error, "number is out of range"}

  def in_english(0), do: {:ok, "zero"}

  def in_english(number) do
    billions = div(number, @billion)
    millions = div(rem(number, @billion), @million)
    thousands = div(rem(number, @million), @thousand)
    remainder = rem(number, @thousand)

    s_billion = section_in_english(billions, "billion")
    s_million = section_in_english(millions, "million")
    s_thousand = section_in_english(thousands, "thousand")
    s_remainder = hundreds_in_english(remainder)

    sections = [s_billion, s_million, s_thousand, s_remainder]
    joined =
      sections
      |> Enum.reject(fn s -> s in ["", " "] end)
      |> Enum.join(" ")
      |> String.trim()

    {:ok, joined}
  end

  defp section_in_english(0, _), do: ""
  defp section_in_english(number_section, section_name) do
    "#{hundreds_in_english(number_section)} #{section_name}"
  end

  defp hundreds_in_english(number) do
    full_hundreds = div(number, 100)
    tens = rem(number, 100)
    if full_hundreds > 0 do
      "#{@dictionary[full_hundreds]} hundred #{tens_in_english(tens)}"
    else
      tens_in_english(tens)
    end
  end

  defp tens_in_english(0), do: ""

  defp tens_in_english(number) do
    full_tens = div(number, 10)
    tens = full_tens * 10
    remainder = rem(number, 10)

    cond do
      number < 20 or number == tens -> @dictionary[number]
      tens == 0 -> @dictionary[remainder]
      remainder == 0 -> @dictionary[tens]
      true -> "#{@dictionary[tens]}-#{@dictionary[remainder]}"
    end
  end
end
