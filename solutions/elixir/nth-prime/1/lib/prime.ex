defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when is_integer(count) and count > 0 do
    primes = Stream.iterate(1, &(&1 + 1))
    |> Enum.reduce_while(%{last_prime: nil, primes_so_far: 0}, fn n, acc ->
      cond do
        acc.primes_so_far == count -> {:halt, acc}
        prime?(n) -> {:cont, %{last_prime: n, primes_so_far: acc.primes_so_far + 1}}
        true -> {:cont, acc}
      end
    end)

    primes.last_prime
  end

  defp prime?(n) when is_integer(n) and n > 1 do
    2 .. n
    |> Enum.reduce_while([1], fn d_candidate, divisors ->
      cond do
        length(divisors) > 2 -> {:halt, divisors}
        rem(n, d_candidate) == 0 -> {:cont, divisors ++ [d_candidate]}
        true -> {:cont, divisors}
      end
    end)
    |> Enum.to_list() == [1, n]
  end

  defp prime?(n) when is_integer(n), do: false
end
