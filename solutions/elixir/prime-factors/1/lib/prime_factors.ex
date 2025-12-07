defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) when number < 2, do: []

  def factors_for(number) do
    primes =
      primes(number)
      |> Enum.filter(&(rem(number, &1) == 0))
      |> Enum.to_list()

    do_factors_for(number, primes)
    |> Enum.sort()
  end

  defp do_factors_for(number, primes), do: do_factors_for(number, primes, [])

  defp do_factors_for(1, _, factors), do: factors
  defp do_factors_for(number, primes, factors) do
    prime_factor =
      primes
      |> Enum.reduce_while(number, fn p, current ->
        cond do
          rem(number, p) == 0 -> {:halt, p}
          true -> {:cont, current}
        end
      end)

    do_factors_for(div(number, prime_factor), primes, [prime_factor | factors])
  end

  defp primes(number) do
    max = if number > 3, do: round(number ** (1/2)), else: number

    eratosthenes(Enum.to_list(2 .. max))
  end

  defp eratosthenes(numbers, primes \\ [])

  defp eratosthenes([], primes), do: Enum.reverse(primes)

  defp eratosthenes([head | tail], primes) do
    filtered = Enum.filter(tail, &(rem(&1, head) != 0))
    eratosthenes(filtered, [head | primes])
  end
end
