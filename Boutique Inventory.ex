defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    # Please implement the sort_by_price/1 function
    Enum.sort_by(inventory, fn product -> product.price end, :asc)
  end

  def with_missing_price(inventory) do
    # Please implement the with_missing_price/1 function
    Enum.filter(inventory, fn product -> product.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    # Please implement the update_names/3 function
    Enum.map(inventory, fn product ->
      %{product | name: String.replace(product.name, old_word, new_word)}
    end)
    
  end

  def increase_quantity(item, count) do
    # Please implement the increase_quantity/2 function
    %{item | quantity_by_size: Map.new(item.quantity_by_size, fn {size, qua} -> {size, qua + count} end)}
  end

  def total_quantity(item) do
    # Please implement the total_quantity/1 function
    Enum.reduce(item.quantity_by_size, 0, fn {_, quantity}, acc -> quantity + acc end)
  end
end
