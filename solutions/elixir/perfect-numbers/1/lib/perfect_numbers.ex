defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) do
    if number < 1 do
      {:error, "Classification is only possible for natural numbers."}
    else
      {_, aliquot_sum} = aliquot_sum(number)
      cond do
        aliquot_sum > number -> {:ok, :abundant}
        aliquot_sum < number -> {:ok, :deficient}
        true -> {:ok, :perfect}
      end
    end
  end

  defp aliquot_sum(number), do: {:ok, Enum.sum(factors(number))}

  defp factors(number) do
    1 .. (number - 1) // 1
    |> Enum.filter(fn n -> rem(number, n) == 0 end)
    |> Enum.to_list()
  end
end
