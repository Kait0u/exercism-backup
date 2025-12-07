defmodule MatchingBrackets do
  @open String.graphemes("([{")
  @close String.graphemes(")]}")
  @brackets @open ++ @close

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    %{open: open, closed: closed, verdict: verdict} =
      str
      |> String.graphemes()
      |> Enum.filter(fn ch -> ch in @brackets end)
      |> Enum.reduce_while(%{open: [], closed: [], verdict: true}, fn ch, acc = %{open: open, closed: closed} ->
        is_closing? = ch in @close

        if is_closing? do
          case open do
            [h_open | t_open] ->
              if encode_open(h_open) == encode_closed(ch) do
                new_acc = %{acc | open: t_open}
                {:cont, new_acc}
              else
                new_acc = %{acc | closed: [ch | closed], verdict: false}
                {:halt, new_acc}
              end
            [] ->
              new_acc = %{acc | closed: [ch | closed], verdict: false}
              {:halt, new_acc}
          end
        else
          new_acc = %{acc | open: [ch | open]}
          {:cont, new_acc}
        end
      end)

    verdict and Enum.empty?(open) and Enum.empty?(closed)
  end

  defp encode_open(ch_input) do
    Enum.find_index(@open, fn ch -> ch == ch_input end)
  end

  defp encode_closed(ch_input) do
    Enum.find_index(@close, fn ch -> ch == ch_input end)
  end
end
