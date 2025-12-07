defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
    do_egg_count(number)
  end

  @spec do_egg_count(integer(), integer()) :: non_neg_integer()
  defp do_egg_count(number, eggs \\ 0)

  defp do_egg_count(0, eggs), do: eggs
  defp do_egg_count(number, eggs) do
    r = rem(number, 2)
    d = div(number, 2)

    do_egg_count(d, eggs + r)
  end
end
