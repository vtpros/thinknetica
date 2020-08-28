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
    @current = 0
  end

  def accelerate
    @speed += 5 # km/h
  end

  def stop
    @speed = 0
  end

  def go_forward
    @current += 1 if current < @route.size - 1
  end

  def go_backward
    @current -= 1 if current.positive?
  end

  def current_station
    @route[@current]
  end

  def next_station
    @route[current + 1] unless current == @route.size - 1
  end

  def previous_station
    @route[current - 1] if current.nonzero?
  end

  def attach
    @cars += 1 if speed.zero?
  end

  def detach
    @cars -= 1 if speed.zero? && cars.positive?
  end

  private

  attr_reader :current
end
