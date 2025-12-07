defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    for row <- 1 .. num do
      for col <- 1 .. row do
        pascal(row, col)
      end
    end
  end

  defp pascal(1, 1), do: 1

  defp pascal(row, col) when row < 1 or col < 1, do: 0

  defp pascal(row, col) when col > row, do: 0

  defp pascal(row, col), do: pascal(row - 1, col) + pascal(row - 1, col - 1)
end
