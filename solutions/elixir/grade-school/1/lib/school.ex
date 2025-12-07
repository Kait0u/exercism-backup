defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @doc """
  Create a new, empty school.
  """
  @spec new() :: school
  def new() do
    []
  end

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(school, name, grade) do
    new_student = {name, grade}

    if already_in_school?(school, new_student) do
      {:error, school}
    else
      {:ok, [new_student | school]}
    end
  end

  defp already_in_school?(school, {name, _}) do
    school
    |> Enum.map(fn {name, _} -> name end)
    |> Enum.find(fn name_internal -> name == name_internal end) != nil
  end

  defp get_current_grade_or_empty(school, grade) do
    school
    |> Enum.filter(fn {_, s_grade} -> s_grade == grade end)
  end

  @doc """
  Return the names of the students in a particular grade, sorted alphabetically.
  """
  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    get_current_grade_or_empty(school, grade)
    |> Enum.map(fn {name, _} -> name end)
    |> Enum.sort()
  end

  @doc """
  Return the names of all the students in the school sorted by grade and name.
  """
  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort_by(fn {name, grade} -> {grade, name} end)
    |> Enum.map(fn {name, _} -> name end)
  end
end
