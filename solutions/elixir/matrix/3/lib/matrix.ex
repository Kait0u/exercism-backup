defmodule Matrix do
  defstruct matrix: nil

  # Assuming a row-major approach

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    list_2d = input
    |> String.split("\n")
    |> Enum.map(fn str_row ->
      str_row
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)

    %Matrix{matrix: list_2d}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%{matrix: list_2d}) do
    list_2d
    |> Enum.map(&(Enum.join(&1, " "))) # Map rows to "x y z" form
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%{matrix: list_2d}) do
    list_2d
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%{matrix: list_2d}, index) do
    list_2d
    |> Enum.at(index - 1)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%{matrix: list_2d}) do
    col_c = length(Enum.at(list_2d, 0))

    for c <- 0 .. (col_c - 1) do
      for row <- list_2d do
        Enum.at(row, c)
      end
    end
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    columns(matrix)
    |> Enum.at(index - 1)
  end
end
