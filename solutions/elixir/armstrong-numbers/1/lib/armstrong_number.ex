defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(0), do: true

  def valid?(number) do
    s_number = to_string(number)
    digit_count = String.length(s_number)

    sum_of_digit_powers = s_number
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&(&1 ** digit_count))
    |> Enum.sum()
    |> round()

    IO.puts("A(#{number}) -- (#{sum_of_digit_powers}) --> #{sum_of_digit_powers == number}")

    sum_of_digit_powers == number
  end
end
