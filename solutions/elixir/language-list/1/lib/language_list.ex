defmodule LanguageList do
  @elixir "Elixir"

  def new(), do: []

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    [_head | tail] = list
    tail
  end

  def first(list) do
    [head | _tail] = list
    head
  end

  def count(list), do: length(list)

  def functional_list?(list), do: @elixir in list
end
