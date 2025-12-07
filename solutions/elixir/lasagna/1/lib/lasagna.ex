defmodule Lasagna do
  @oven_time_minutes 40
  @layer_time_minutes 2

  # Please define the 'expected_minutes_in_oven/0' function
  def expected_minutes_in_oven(), do: @oven_time_minutes

  # Please define the 'remaining_minutes_in_oven/1' function
  def remaining_minutes_in_oven(time_passed_minutes), do: @oven_time_minutes - time_passed_minutes

  # Please define the 'preparation_time_in_minutes/1' function
  def preparation_time_in_minutes(layer_count), do: layer_count * @layer_time_minutes

  # Please define the 'total_time_in_minutes/2' function
  def total_time_in_minutes(layer_count, oven_time_passed_minutes), do: preparation_time_in_minutes(layer_count) + oven_time_passed_minutes

  # Please define the 'alarm/0' function
  def alarm(), do: "Ding!"
end
