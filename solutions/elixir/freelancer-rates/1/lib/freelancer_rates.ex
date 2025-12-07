defmodule FreelancerRates do
  @hours_per_day 8.0
  @days_per_month 22

  @spec daily_rate(number()) :: number()
  def daily_rate(hourly_rate) do
    @hours_per_day * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1.0 - discount_as_decimal(discount))
  end

  def monthly_rate(hourly_rate, discount) do
    after_discount = apply_discount(@days_per_month * daily_rate(hourly_rate), discount) |> Float.ceil()
    Float.ceil(after_discount) |> trunc()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    days = budget / apply_discount(daily_rate(hourly_rate), discount)
    Float.floor(days, 1)
  end

  defp discount_as_decimal(discount) do
    discount / 100
  end
end
