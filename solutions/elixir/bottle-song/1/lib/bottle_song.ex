defmodule BottleSong do
  @moduledoc """
  Handles lyrics of the popular children song: Ten Green Bottles
  """

  @int_to_english_map %{
    0 => "no", # has to be no for storytelling reasons
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten"
  }

  @spec recite(pos_integer, pos_integer) :: String.t()

  def recite(0, _), do: ""
  def recite(_, 0), do: ""

  def recite(start_bottle, take_down) do
    current_bottles = @int_to_english_map[start_bottle]
    current_plural? = start_bottle != 1

    remaining = start_bottle - 1
    remaining_bottles = @int_to_english_map[remaining]
    remaining_plural? = remaining != 1

    verse =
      """
      #{String.capitalize(current_bottles)} green bottle#{if current_plural?, do: "s", else: ""} hanging on the wall,
      #{String.capitalize(current_bottles)} green bottle#{if current_plural?, do: "s", else: ""} hanging on the wall,
      And if one green bottle should accidentally fall,
      There'll be #{remaining_bottles} green bottle#{if remaining_plural?, do: "s", else: ""} hanging on the wall.
      """

    result =
      """
      #{verse}
      #{recite(start_bottle - 1, take_down - 1)}
      """

    String.trim(result)
  end
end
