defmodule NameBadge do
  @separator " - "
  @owner_department "OWNER"

  def print(id, name, department) when id == nil do
    badge = idless_part(name, department)
    badge
  end

  def print(id, name, department) do
    badge = Enum.join(
      [id_part(id), idless_part(name, department)], @separator
    )
    badge
  end

  defp id_part(id), do: "[#{id}]"

  defp idless_part(name, department) do
    parts = [
      name,
      (if !department, do: @owner_department, else: String.upcase(department))
    ]

    Enum.join(parts, @separator)
  end
end
