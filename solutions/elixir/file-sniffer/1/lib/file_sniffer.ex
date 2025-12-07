defmodule FileSniffer do
  @ext_type_map %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  @binary_sigs %{
    <<0x7F, 0x45, 0x4C, 0x46>> => "application/octet-stream",
    <<0x42, 0x4D>> => "image/bmp",
    <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>> => "image/png",
    <<0xFF, 0xD8, 0xFF>> => "image/jpg",
    <<0x47, 0x49, 0x46>> => "image/gif"
  }

  def type_from_extension(extension) do
    Map.get(@ext_type_map, extension)
  end

  def type_from_binary(binary) when not is_binary(binary) or byte_size(binary) < 2, do: nil

  def type_from_binary(binary) do
    head = binary_part(binary, 0, min(byte_size(binary), 8))

    found = @binary_sigs
      |> Enum.find(fn {sig, _} -> String.starts_with?(head, sig) end)

    case found do
      nil -> nil
      {_, type} -> type
    end
  end

  def verify(file_binary, extension) do
    type_bin = type_from_binary(file_binary)
    type_ext = type_from_extension(extension)


    if type_bin == type_ext and !is_nil(type_bin) do
      {:ok, type_bin}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end
