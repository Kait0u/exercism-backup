defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @ship_registry_number_start 1000
  @ship_registry_number_end 9999

  @stardate_start 41000.0
  @stardate_end 42000.0

  defp randfloat(a, b) do
    a + (b - a) * :rand.uniform()
  end

  defp randint(a, b) do
    randfloat(a, b)
    |> round()
  end

  def random_planet_class() do
    @planetary_classes
    |> Enum.random()
  end

  def random_ship_registry_number() do
    "NCC-#{randint(@ship_registry_number_start, @ship_registry_number_end + 1)}"
  end

  def random_stardate() do
    randfloat(@stardate_start, @stardate_end)
  end

  def format_stardate(stardate) do
    to_string(:io_lib.format("~.1f", [stardate]))
  end
end
