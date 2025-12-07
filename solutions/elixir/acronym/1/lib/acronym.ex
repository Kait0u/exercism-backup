defmodule Acronym do
  @word_regex ~r/([a-zA-Z])['\w]*/u

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(@word_regex, string)
    |> Enum.map(fn [_, letter] -> letter end)
    |> Enum.join()
    |> String.upcase()
  end
end
