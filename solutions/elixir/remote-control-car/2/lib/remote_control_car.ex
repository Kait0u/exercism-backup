defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, :distance_driven_in_meters, :battery_percentage]

  @type t :: %__MODULE__{
    nickname: String.t(),
    distance_driven_in_meters: pos_integer(),
    battery_percentage: pos_integer()
  }


  def new(name \\ "none") do
    %RemoteControlCar{
      nickname: name,
      distance_driven_in_meters: 0,
      battery_percentage: 100
    }
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: dist}), do: "#{dist} meters"

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%RemoteControlCar{battery_percentage: battery_percentage}), do: "Battery at #{battery_percentage}%"

  def drive(remote_car = %RemoteControlCar{battery_percentage: 0}), do: remote_car

  def drive(remote_car = %RemoteControlCar{distance_driven_in_meters: dist, battery_percentage: battery}) do
    %RemoteControlCar{remote_car | battery_percentage: battery - 1, distance_driven_in_meters: dist + 20}
  end
end
