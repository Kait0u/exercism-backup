defmodule Lasagna do
  @oven_time_minutes 40
  @layer_time_minutes 2

  def expected_minutes_in_oven(), do: @oven_time_minutes

  def remaining_minutes_in_oven(time_passed_minutes), do: expected_minutes_in_oven() - time_passed_minutes

  def preparation_time_in_minutes(layer_count), do: layer_count * @layer_time_minutes

  def total_time_in_minutes(layer_count, oven_time_passed_minutes), do: preparation_time_in_minutes(layer_count) + oven_time_passed_minutes

  def alarm(), do: "Ding!"
end
