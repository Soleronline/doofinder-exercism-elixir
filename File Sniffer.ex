defmodule FileSniffer do
  @info_file %{
    exe: [
          media: "application/octet-stream",
          binary: <<0x7F, 0x45, 0x4C, 0x46>>,
    ],
    bmp: [
          media: "image/bmp",
          binary: <<0x42, 0x4D>>,
    ],
    png: [
          media: "image/png",
          binary: <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>,
    ],
    jpg: [
          media: "image/jpg",
          binary: <<0xFF, 0xD8, 0xFF>>,
    ],
    gif: [
          media: "image/gif",
          binary: <<0x47, 0x49, 0x46>>
    ]
  }
  @error_msg "Warning, file format and file extension do not match."

  def type_from_extension(extension) do
    # Please implement the type_from_extension/1 function
    @info_file[String.to_atom(extension)][:media]
  end

  defp search_binary(binary_signature, file_binary) do
    size_binary = byte_size(binary_signature)
    if size_binary > byte_size(file_binary) do
      nil
    else
      <<first_bytes::binary-size(size_binary), _::binary>> = file_binary
      first_bytes
    end
  end

  def type_from_binary(file_binary) do
    ext = Enum.filter(Map.keys(@info_file), fn key -> 
        search_binary(@info_file[key][:binary], file_binary) == @info_file[key][:binary]
    end)|>List.first
    @info_file[ext][:media]
  end

  def verify(file_binary, extension) do
    if type_from_extension(extension) == type_from_binary(file_binary) do
      {:ok, type_from_extension(extension)}
    else
      {:error, @error_msg}
    end
  end
end
