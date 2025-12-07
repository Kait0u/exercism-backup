defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    <<b4::1, b3::1, b2::1, b1::1, b0::1>> = <<code::size(5)>>

    operations = []

    operations = if b0 == 1, do: ["wink" | operations], else: operations
    operations = if b1 == 1, do: ["double blink" | operations], else: operations
    operations = if b2 == 1, do: ["close your eyes" | operations], else: operations
    operations = if b3 == 1, do: ["jump" | operations], else: operations
    # Counter-intuitive, but the list is already reversed:
    operations = if b4 == 1, do: operations, else: Enum.reverse(operations)

    operations
  end
end
