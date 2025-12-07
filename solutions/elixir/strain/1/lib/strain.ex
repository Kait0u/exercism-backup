defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    do_select(list, fun)
  end

  @spec do_select(list :: list(any), fun :: (any -> boolean), acc :: list(any)) :: list(any)
  defp do_select(list, fun, acc \\ [])

  defp do_select([], _, acc), do: acc
  defp do_select([head | tail], fun, acc) do
    if fun.(head) do
      do_select(tail, fun, acc ++ [head])
    else
      do_select(tail, fun, acc)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    neg_fun = &(not fun.(&1))
    do_select(list, neg_fun)
  end
end
