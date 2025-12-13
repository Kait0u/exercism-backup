defmodule Garden do
  @default_names [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @encodings %{
    "G" => :grass,
    "C" => :clover,
    "R" => :radishes,
    "V" => :violets
  }

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    names_sorted = Enum.sort(student_names)
    garden_as_lists = garden_to_lists(info_string)

    student_names
    |> Enum.reduce(%{}, fn name, info ->
      student_number = student_number(names_sorted, name)
      Map.put(info, name, get_all_offset_decoded(garden_as_lists, student_number))
    end)
  end

  defp garden_to_lists(info_string) do
    info_string
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end

  defp student_number(names, name), do:
    names
    |> Enum.find_index(&(&1 == name))

  defp get_at_position(rows = [_, _], row_idx, col_idx) do
    rows
    |> Enum.at(row_idx)
    |> Enum.at(col_idx)
  end

  defp decode(ch), do: @encodings[ch]

  defp get_all_offset(garden_as_lists, n) do
    offset = 2 * n
    [
      get_at_position(garden_as_lists, 0, offset),
      get_at_position(garden_as_lists, 0, offset + 1),
      get_at_position(garden_as_lists, 1, offset),
      get_at_position(garden_as_lists, 1, offset + 1)
    ]
    |> Enum.filter(&(&1 != nil))
    |> List.to_tuple()
  end

  defp get_all_offset_decoded(garden_as_lists, n) do
    get_all_offset(garden_as_lists, n)
    |> Tuple.to_list()
    |> Enum.map(&decode/1)
    |> List.to_tuple()
  end
end
