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

  defp sublist?(a, b) when length(a) > length(b), do: false
  defp sublist?(a, b) do
    verdict = b |> List.starts_with?(a)

    if verdict do
      verdict
    else
      [_ | b_tail] = b
      sublist?(a, b_tail)
    end
  end

  defp superlist?(a, b) do
    sublist?(b, a)
  end

end
