defmodule Sublist do
  @type outcome :: :equal | :sublist | :superlist | :unequal

  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      equal?(a, b) -> :equal
      superlist?(a, b) -> :superlist
      sublist?(a, b) -> :sublist
      true -> :unequal
    end
  end

  defp equal?(a, b), do: a == b
  defp superlist?(a, b), do: length(a) >= length(b) and b |> Enum.all?(&(&1 in a))
  defp sublist?(a, b), do: length(b) >= length(a) and a |> Enum.all?(&(&1 in b))
end
