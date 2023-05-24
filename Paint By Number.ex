defmodule PaintByNumber do
  defp calculate_bit_size(color_count, exponent) do
    if Integer.pow(2, exponent) < color_count do
      calculate_bit_size(color_count, exponent + 1)
    else
      exponent
    end
  end
  def palette_bit_size(color_count) do
    # Please implement the palette_bit_size/1 function
    calculate_bit_size(color_count, 1)
  end

  def empty_picture() do
    # Please implement the empty_picture/0 function
    <<>>
  end

  def test_picture() do
    # Please implement the test_picture/0 function
    <<0::2, 1::2, 10::2, 11::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    # Please implement the prepend_pixel/3 function
    bit_size = palette_bit_size(color_count)
    info = <<pixel_color_index::size(bit_size)>>
    <<info::bitstring, picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil
  def get_first_pixel(picture, color_count) do
    # Please implement the get_first_pixel/2 function
    bit_size = palette_bit_size(color_count)
    <<first_pixel::size(bit_size), _::bitstring>> = picture
    first_pixel
  end

  def drop_first_pixel(<<>>, _), do: ""
  def drop_first_pixel(picture, color_count) do
    # Please implement the drop_first_pixel/2 function
    bit_size = palette_bit_size(color_count)
    <<_::size(bit_size), new_picture::bitstring>> = picture
    new_picture
  end

  def concat_pictures(<<>>, <<>>), do: <<>>
  def concat_pictures(picture1, <<>>), do: picture1
  def concat_pictures(<<>>, picture2), do: picture2
  def concat_pictures(picture1, picture2) do
    # Please implement the concat_pictures/2 function
    <<picture1::bitstring, picture2::bitstring>>
  end
end
