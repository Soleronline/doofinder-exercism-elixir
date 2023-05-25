defmodule RemoteControlCar do
  @meter 20
  @porc_battery 1
  # Please implement the struct with the specified fields
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]

  def new() do
    # Please implement the new/0 function
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    # Please implement the new/1 function
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(remote_car = %RemoteControlCar{}) do
    # Please implement the display_distance/1 function
    "#{remote_car.distance_driven_in_meters} meters"
  end

  def display_battery(remote_car = %RemoteControlCar{}) do
    # Please implement the display_battery/1 function
    if remote_car.battery_percentage >= 1 do
      "Battery at #{remote_car.battery_percentage}%"
    else
      "Battery empty"
    end
  end

  def drive(remote_car = %RemoteControlCar{}) do
    # Please implement the drive/1 function
    if remote_car.battery_percentage >= 1 do
      meters = remote_car.distance_driven_in_meters + @meter
      battery = remote_car.battery_percentage - @porc_battery
      %{remote_car | distance_driven_in_meters: meters, battery_percentage: battery}
    else
      remote_car
    end
  end
end