defmodule Luhn do
  @regex_number ~r/^\d{2,}$/

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    preprocessed_number = preprocess_number(number)

    if !Regex.match?(@regex_number, preprocessed_number) do
       false
    else
      valid_luhn?(preprocessed_number)
    end
  end

  defp preprocess_number(number) do
    number
    |> String.replace(~r/\s+/, "")
  end

  defp valid_luhn?(number) do
    postprocessing_sum =
      number
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.map(fn {digit, idx} ->
        if rem(idx, 2) == 1 do
          digit
        else
          new_digit = 2 * digit
          if new_digit > 9, do: new_digit - 9, else: new_digit
        end
      end)
      |> Enum.sum()

    rem(postprocessing_sum, 10) == 0
  end
end
