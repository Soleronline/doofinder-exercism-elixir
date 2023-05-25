defmodule BoutiqueSuggestions do
  @maximum_price 100.0
  def get_combinations(tops, bottoms, options \\ []) do
    # Please implement the get_combinations/3 function
    maximum_price = options[:maximum_price] || @maximum_price

    for top <- tops,
        bottom <- bottoms,
        top[:base_color] != bottom[:base_color] and (top[:price] + bottom[:price]) < maximum_price do
        {top, bottom}
    end
  end
end