defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class() do
    # Please implement the random_planet_class/0 function
    Enum.random(@planetary_classes)
  end

  def random_ship_registry_number() do
    # Please implement the random_ship_registry_number/0 function
    "NCC-#{Enum.random(1000..9999)}"
  end

  def random_stardate() do
    # Please implement the random_stardate/0 function
    1000 * :rand.uniform + 41000
  end

  def format_stardate(stardate) do
    # Please implement the format_stardate/1 function
    to_string(:io_lib.format('~.1f', [stardate]))
  end
end
