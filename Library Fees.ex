defmodule LibraryFees do
  @day_after_noon 28
  @day_before_noon 29
  @discount_return_monday 0.50
  @second_of_a_day 24 * 60 * 60
  def datetime_from_string(string) do
    # Please implement the datetime_from_string/1 function
    {_, datetime} = NaiveDateTime.from_iso8601(string)
    datetime
  end

  def before_noon?(datetime) do
    # Please implement the before_noon?/1 function
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    # Please implement the return_date/1 function
    days_until_checkout = if before_noon?(checkout_datetime), do: @day_after_noon, else: @day_before_noon
    NaiveDateTime.to_date(    
      NaiveDateTime.add(checkout_datetime, days_until_checkout * @second_of_a_day, :second)
    )
  end

  def days_late(planned_return_date, actual_return_datetime) do
    # Please implement the days_late/2 function
    diff = Date.diff(
      NaiveDateTime.to_date(actual_return_datetime),
      planned_return_date
    )
    if diff > 0, do: diff, else: 0
  end

  def monday?(datetime) do
    # Please implement the monday?/1 function
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    # Please implement the calculate_late_fee/3 function
    date_checkout = datetime_from_string(checkout)
    date_returned = datetime_from_string(return)
    date_must_return = return_date(date_checkout)
    day_late = days_late(date_must_return, date_returned)
    if monday?(date_returned), do: floor(day_late * rate * @discount_return_monday), else: day_late * rate
  end
end
