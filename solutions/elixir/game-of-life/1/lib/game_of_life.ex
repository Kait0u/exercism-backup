defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of cells
  """

  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []
  def tick(matrix), do: eval_rules(matrix)

  @spec eval_rules(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  defp eval_rules(matrix) do
    {rows, cols} = matrix_dims(matrix)

    for row_idx <- 0 .. (rows - 1) do
      for col_idx <- 0 .. (cols - 1) do
        eval_rules(matrix, row_idx, col_idx)
      end
    end
  end

  @spec eval_rules(matrix :: list(list(0 | 1)), row_idx :: non_neg_integer(), col_idx :: non_neg_integer()) :: 0 | 1
  defp eval_rules(matrix, row_idx, col_idx) do
    cond do
      should_vivify?(matrix, row_idx, col_idx) -> 1
      should_live_on?(matrix, row_idx, col_idx) -> 1
      true -> 0
    end
  end

  @spec should_vivify?(matrix :: list(list(0 | 1)), row_idx :: non_neg_integer(), col_idx :: non_neg_integer()) :: boolean()
  defp should_vivify?(matrix, row_idx, col_idx) do
    if matrix_at(matrix, row_idx, col_idx) != 0 do
      false
    else
      neighbors = neighborhood(matrix, row_idx, col_idx)

      neighbors
      |> Enum.sum() == 3
    end
  end

  @spec should_live_on?(matrix :: list(list(0 | 1)), row_idx :: non_neg_integer(), col_idx :: non_neg_integer()) :: boolean()
  defp should_live_on?(matrix, row_idx, col_idx) do
    if matrix_at(matrix, row_idx, col_idx) != 1 do
      false
    else
      neighbors = neighborhood(matrix, row_idx, col_idx)

      sum =
        neighbors
        |> Enum.sum()

      sum in [2, 3]
    end
  end

  @spec neighborhood(matrix :: list(list(0 | 1)), row_idx :: non_neg_integer(), col_idx :: non_neg_integer()) :: list(0 | 1)
  defp neighborhood(matrix, row_idx, col_idx) do
    for row_incr <- [-1, 0, 1], col_incr <- [-1, 0, 1], {row_incr, col_incr} != {0, 0} do
      matrix_at(matrix, row_idx + row_incr, col_idx + col_incr)
    end
    |> Enum.filter(&(&1 != nil))
  end

  @spec matrix_at(matrix :: list(list(0 | 1)), row_idx :: non_neg_integer(), col_idx :: non_neg_integer()) :: 0 | 1
  defp matrix_at(matrix, row_idx, col_idx) do
    {rows, cols} = matrix_dims(matrix)

    cond do
      row_idx < 0 -> nil
      col_idx < 0 -> nil
      rows <= row_idx -> nil
      cols <= col_idx -> nil
      true ->
        matrix
        |> Enum.at(row_idx)
        |> Enum.at(col_idx)
    end
  end

  @spec matrix_dims(matrix :: list(list(0 | 1))) :: {non_neg_integer(), non_neg_integer()}
  defp matrix_dims(matrix), do: {length(matrix), length(Enum.at(matrix, 0))}
end
