defmodule TwoFer do
  @message_template "One for <<name>>, one for me."
  @key_name "<<name>>"
  @fallback_name "you"

  @doc """
  Two-fer or 2-fer is short for two for one. One for you and one for me.
  """
  @spec two_fer(String.t()) :: String.t()
  def two_fer(name \\ @fallback_name) do
    String.replace(@message_template, @key_name, name)
  end
end
