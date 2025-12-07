defmodule BirdCount do
  @busy_day_min_threshold 5

  def today([]), do: nil
  def today([head | _tail]), do: head

  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]


  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | tail]), do:
    head == 0 or has_day_without_birds?(tail)


  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)


  def busy_days([]), do: 0
  def busy_days([head | tail]) do
    today_score = cond do
      head >= @busy_day_min_threshold -> 1
      true -> 0
    end
    busy_days(tail) + today_score
  end
end
