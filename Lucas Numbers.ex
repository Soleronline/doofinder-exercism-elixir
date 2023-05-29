defmodule LucasNumbers do
    @moduledoc """
    Lucas numbers are an infinite sequence of numbers which build progressively
    which hold a strong correlation to the golden ratio (φ or ϕ)
  
    E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...
    """
    defp sum(a, b, count) do
      result = a + b
      c = if count > 0 do
        sum(b, result, count - 1)
      else
        nil
      end
      if is_nil(c) do
        [result]
      else
        [result | c]
      end
    end
  
    def generate(count) when is_integer(count) and count > 0 do
      # Please implement the generate/1 function
      if count == 1 do
          [2]
      else
        if count == 2 do
          [2, 1]
        else
          [2, 1] ++ sum(2, 1, count - 3)
        end
      end
    end
    def generate(_), do: raise ArgumentError, message: "count must be specified as an integer >= 1"
  end
  