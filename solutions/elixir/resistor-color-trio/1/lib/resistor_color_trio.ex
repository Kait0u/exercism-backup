defmodule ResistorColorTrio do
  @color_to_number %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9,
  }

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    c_tens = Enum.at(colors, 0)
    c_ones = Enum.at(colors, 1)
    c_zeroes = Enum.at(colors, 2)

    ohms = (@color_to_number[c_tens] * 10 + @color_to_number[c_ones]) * Integer.pow(10, @color_to_number[c_zeroes])
    convert_units(ohms)
  end

  defp convert_units(value, curr_unit \\ :ohms, remaining_units \\ [:kiloohms, :megaohms, :gigaohms])

  defp convert_units(value, curr_unit, []), do: {value, curr_unit}
  defp convert_units(value, curr_unit, _) when value < 1000, do: {value, curr_unit}

  defp convert_units(value, _, [next_unit | remaining_units]), do:
    convert_units(value / 1000, next_unit, remaining_units)
end
