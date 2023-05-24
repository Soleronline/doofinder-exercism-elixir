defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    # Please implement the get_volume/1 function
    elem volume_pair, 1
  end

  def to_milliliter({:cup, volume}) do
    # Please implement the to_milliliter/1 functions
    {:milliliter, volume * 240}
  end
  def to_milliliter({:fluid_ounce, volume}) do
    # Please implement the to_milliliter/1 functions
    {:milliliter, volume * 30.0}
  end
  def to_milliliter({:teaspoon, volume}) do
    # Please implement the to_milliliter/1 functions
    {:milliliter, volume * 5.0}
  end
  def to_milliliter({:tablespoon, volume}) do
    # Please implement the to_milliliter/1 functions
    {:milliliter, volume * 15.0}
  end
  def to_milliliter({:milliliter, _} = volume_pair) do
    # Please implement the to_milliliter/1 functions
    volume_pair
  end

  def from_milliliter({:milliliter, volume}, :cup = unit) do
    # Please implement the from_milliliter/2 functions
    {unit, volume / 240.0}
  end
  def from_milliliter({:milliliter, volume}, :fluid_ounce = unit) do
    # Please implement the from_milliliter/2 functions
    {unit, volume / 30.0}
  end
  def from_milliliter({:milliliter, volume}, :teaspoon = unit) do
    # Please implement the from_milliliter/2 functions
    {unit, volume / 5.0}
  end
  def from_milliliter({:milliliter, volume}, :tablespoon = unit) do
    # Please implement the from_milliliter/2 functions
    {unit, volume / 15.0}
  end
  def from_milliliter({:milliliter, _} = volume_pair, :milliliter) do
    # Please implement the from_milliliter/2 functions
    volume_pair
  end

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
