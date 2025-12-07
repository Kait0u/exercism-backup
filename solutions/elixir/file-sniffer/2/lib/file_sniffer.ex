defmodule FileSniffer do
  @ext_type_map %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  def type_from_extension(extension) do
    Map.get(@ext_type_map, extension)
  end

  def type_from_binary(bin) do
    ext = case bin do
      <<0x7F, 0x45, 0x4C, 0x46, _rest::binary>> -> "exe"
      <<0x42, 0x4D, _rest::binary>> -> "bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>> -> "png"
      <<0xFF, 0xD8, 0xFF, _rest::binary>> -> "jpg"
      <<0x47, 0x49, 0x46, _rest::binary>> -> "gif"
      _ -> nil
    end

    type_from_extension(ext)
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
