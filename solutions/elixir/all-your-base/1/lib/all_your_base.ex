defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base)

  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}

  def convert(digits, input_base, output_base) when input_base == output_base, do: {:ok, digits}

  def convert(digits, input_base, output_base) do
    cond do
      !validate_digits(digits, input_base) -> {:error, "all digits must be >= 0 and < input base"}
      true ->
        result = digits
        |> convert_to_10(input_base)
        |> convert_from_10(output_base)

        {:ok, result}
    end
  end

  defp convert_to_10(digits, input_base) when input_base == 10, do: decimal_digits_to_number(digits)
  defp convert_to_10(digits, input_base) do
    digits
      |> Enum.reverse()
      |> Enum.reduce(
        %{value: 0, exponent: 0},
        fn (digit, %{value: value, exponent: exponent}) ->
          %{
            value: value + digit * trunc(:math.pow(input_base, exponent)),
            exponent: exponent + 1
          }
        end
      )
      |> Map.get(:value)
  end

  defp decimal_digits_to_number(digits) do
    digits
    |> Enum.join()
    |> String.to_integer()
  end

  defp convert_from_10(dec_value, target_base) do
    do_convert_from_10(dec_value, target_base)
  end

  defp do_convert_from_10(dec_value, target_base, acc_digits \\ [])
  defp do_convert_from_10(0, _, acc_digits) when length(acc_digits) == 0, do: [0]
  defp do_convert_from_10(0, _, acc_digits), do: acc_digits

  defp do_convert_from_10(dec_value, target_base, acc_digits) do
    do_convert_from_10(
      div(dec_value, target_base),
      target_base,
      [rem(dec_value, target_base) | acc_digits]
    )
  end

  defp validate_digits(digits, input_base), do: is_nil(
    Enum.find(digits, &(&1 < 0 or &1 >= input_base))
  )
end
