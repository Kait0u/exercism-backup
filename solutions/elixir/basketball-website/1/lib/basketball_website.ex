defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract(
      data,
      path |> String.split(~r{\.})
    )
  end

  defp do_extract(nil, _), do: nil
  defp do_extract(data, []), do: data

  defp do_extract(data, [path_head | path_tail]) do
    new_data = data[path_head]
    do_extract(new_data, path_tail)
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, path |> String.split(~r{\.}))
  end
end
