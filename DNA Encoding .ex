defmodule DNA do
  @table [
    [' ', 0b0000],
    [?A, 0b0001],
    [?C, 0b0010],
    [?G, 0b0100],
    [?T, 0b1000],
  ]
  defp find_encode_nucleotide([], _, _, _), do: 0
  defp find_encode_nucleotide([nucleo | table], position_from, position_until, code_point) do
    if Enum.at(nucleo, position_from) == code_point do
      Enum.at(nucleo, position_until)
    else
      find_encode_nucleotide(table, position_from, position_until, code_point)
    end
  end
  def encode_nucleotide(code_point) do
    # Please implement the encode_nucleotide/1 function
    find_encode_nucleotide(@table, 0, 1, code_point)
  end

  def decode_nucleotide(encoded_code) do
    # Please implement the decode_nucleotide/1 function
    if encoded_code == 0 do
      32
    else
      find_encode_nucleotide(@table, 1, 0, encoded_code)
    end
  end

  defp get_bit([bit|rest]) do
    if rest != [] do
      << <<encode_nucleotide(bit) :: 4>>, << get_bit(rest) :: bitstring >> >>
    else
      <<encode_nucleotide(bit) :: 4>>
    end
  end

  defp get_bit(<< bit :: 4, rest :: bitstring >>) do
    if rest != "" do
      [decode_nucleotide(bit) | get_bit(rest)]
    else
      [decode_nucleotide(bit)]
    end
  end

  def encode(dna) do
    # Please implement the encode/1 function
    get_bit(dna)
  end

  def decode(dna) do
    # Please implement the decode/1 function
    get_bit(dna)
  end
end
