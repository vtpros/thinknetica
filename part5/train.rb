# Train class
class Train
  attr_reader :number, :type, :cars, :speed

  def initialize(number:, type:)
    @number = number
    @type = type
    @cars = []
    @speed = 0
  end

  def route=(route)
    return if @route == route
    @route = route
    @current = 0
    @route.stations[current].receive(self)
  end

  def current_station
    return unless @route
    @route[@current]
  end

  def accelerate
    @speed += 5 # km/h
  end

  def stop
    @speed = 0
  end

  def go_forward
    return unless @route && current < @route.size - 1
    @route.stations[current].send(self)
    @route.stations[current+1].receive(self)
    @current += 1
  end

  def go_backward
    return unless @route && current.positive?
    @route.stations[current].send(self)
    @route.stations[current-1].receive(self)
    @current -= 1
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

  def attach(car)
    @cars << car if speed.zero? && car.type == type && !cars.include?(car)
  end

  def detach(car)
    cars if speed.zero? && @cars.delete(car)
  end

  private

  # :current is a helper method to get a current station index
  attr_reader :current
end
