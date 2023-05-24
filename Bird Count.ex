defmodule BirdCount do
  def today(list) do
    # Please implement the today/1 function
    if length(list) == 0 do
      nil
    else
      [today | _] = list
      today
    end
  end

  def increment_day_count(list) do
    # Please implement the increment_day_count/1 function
    if length(list) == 0 do
      [1]
    else
      [today | more_days] = list
      [today + 1 | more_days]
    end
  end

  def has_day_without_birds?(list) do
    # Please implement the has_day_without_birds?/1 function
    0 in list
  end

  defp sum([]), do: 0
  defp sum([birds | more_days]), do: birds + sum(more_days)

  def total(list) do
    # Please implement the total/1 function
    sum(list)
  end

  defp busy([]), do: 0
  defp busy([birds| more_days]) do
    
    if birds >= 5 do
      1 + busy(more_days)
    else
      busy(more_days)
    end
    
  end
  def busy_days(list) do
    # Please implement the busy_days/1 function
    busy(list)
  end
end
