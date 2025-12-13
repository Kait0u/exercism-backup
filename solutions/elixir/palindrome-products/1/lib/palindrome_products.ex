defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)

  def generate(max_factor, min_factor) when max_factor < min_factor, do: raise ArgumentError

  def generate(max_factor, min_factor) do
  for f1 <- min_factor..max_factor,
      f2 <- f1..max_factor,
      prod = f1 * f2,
      palindrome?(Integer.to_string(prod)),
      reduce: %{} do
    acc ->
      Map.update(acc, prod, [[f1, f2]], &[ [f1, f2] | &1 ])
    end
  end

  defp palindrome?(string) do
    string == String.reverse(string)
  end
end
