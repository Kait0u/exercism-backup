defmodule LucasNumbers do
  @moduledoc """
  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)

  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
  """
  def generate(arg) when not is_integer(arg) or not (is_integer(arg) and arg >= 1), do:
    raise ArgumentError.exception("count must be specified as an integer >= 1")

  def generate(count) do
    1 .. count
    |> Stream.map(&lucas/1)
    |> Enum.to_list()
  end

  defp lucas(1), do: 2
  defp lucas(2), do: 1
  defp lucas(n) when is_integer(n) and n > 2, do: lucas(n - 1) + lucas(n - 2)
end
