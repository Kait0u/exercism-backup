defmodule HighSchoolSweetheart do
  def first_letter(name), do:
    name |> String.trim() |> String.first()

  def initial(name), do: first_letter(name) |> String.upcase() |> Kernel.<>(".")

  def initials(full_name) do
    full_name
    |> String.split(" ")
    |> Enum.map(&initial/1)
    |> Enum.join(" ")
  end

  def pair(full_name1, full_name2) do
    # ❤-------------------❤
    # |  X. X.  +  X. X.  |
    # ❤-------------------❤

    initials1 = initials(full_name1)
    initials2 = initials(full_name2)

    """
    ❤-------------------❤
    |  #{initials1}  +  #{initials2}  |
    ❤-------------------❤
    """
  end
end
