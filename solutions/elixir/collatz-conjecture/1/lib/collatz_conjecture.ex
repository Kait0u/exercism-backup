defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when input == 1, do: 0

  def calc(input) when rem(input, 2) == 0, do: 1 + calc(Integer.floor_div(input, 2))

  def calc(input), do: 1 + calc(3 * input + 1)
end
