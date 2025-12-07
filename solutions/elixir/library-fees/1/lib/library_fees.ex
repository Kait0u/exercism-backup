defmodule LibraryFees do
  @monday_discount_rate_percent 50

  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    # Please implement the before_noon?/1 function
    noon_date_time = NaiveDateTime.beginning_of_day(datetime)
      |> NaiveDateTime.add(12, :hour)

    NaiveDateTime.compare(datetime, noon_date_time) == :lt
  end

  def return_date(checkout_datetime) do
    lease_days = if before_noon?(checkout_datetime), do: 28, else: 29

    NaiveDateTime.to_date(checkout_datetime)
      |> Date.add(lease_days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_date = NaiveDateTime.to_date(actual_return_datetime)

    max(0, Date.diff(actual_return_date, planned_return_date))
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime) |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = NaiveDateTime.from_iso8601!(checkout)
    return_datetime = NaiveDateTime.from_iso8601!(return)

    planned_return_date = return_date(checkout_datetime)

    delay = days_late(planned_return_date, return_datetime)
    base_fee = delay * rate

    if monday?(return_datetime), do: apply_monday_return_discount(base_fee), else: base_fee
  end

  defp apply_monday_return_discount(fee), do: div((@monday_discount_rate_percent * fee), 100)
end
