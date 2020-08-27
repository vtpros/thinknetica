# Train class
class Train
  attr_reader :number, :type, :cars, :speed

  def initialize(number:, type:, cars:)
    @number = number
    @type = type
    @cars = cars
    @speed = 0
  end

  def route=(route)
    @route = route
    @current_station = 0
  end

  def accelerate
    @speed += 5 # km/h
  end

  def stop
    @speed = 0
  end

  def go_forward
    @current_station < @route.size - 1 ? @current_station += 1 : nil
  end

  def go_backward
    @current_station.positive? ? @current_station -= 1 : nil
  end

  def current_station
    @route[@current_station]
  end

  def next_station
    at_destination = @current_station == @route.size - 1
    !at_destination ? @route[@current_station + 1] : nil
  end

  def previous_station
    @current_station.nonzero? ? @route[@current_station - 1] : nil
  end

  def attach
    speed.zero? ? @cars += 1 : nil
  end

  def detach
    speed.zero? && @cars.positive? ? @cars -= 1 : nil
  end
end
