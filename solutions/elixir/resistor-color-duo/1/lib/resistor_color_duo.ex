defmodule ResistorColorDuo do
  @encoding_map %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }
  @code_length 2

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value(colors) do
    colors
    |> Enum.map(&name_to_code/1)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.take(@code_length)
    |> Enum.join()
    |> String.to_integer()
  end

  @spec name_to_code(color :: atom()) :: integer
  defp name_to_code(color) do
    Map.get(@encoding_map, color)
  end
end
