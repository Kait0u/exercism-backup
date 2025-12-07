defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      question?(input) and yelled?(input) ->
        "Calm down, I know what I'm doing!"
      question?(input) ->
        "Sure."
      yelled?(input) ->
        "Whoa, chill out!"
      silent?(input) ->
        "Fine. Be that way!"
      true ->
        "Whatever."
    end
  end

  defp silent?(string) do
    String.length(string) == 0
      or String.length(String.trim(string)) == 0
  end

  defp yelled?(string) do
    String.trim(string)
    |> String.length() > 1
      and String.upcase(string) == string
      and String.downcase(string) != string
  end

  defp question?(string) do
    String.trim(string)
    |> String.ends_with?("?")
  end
end
