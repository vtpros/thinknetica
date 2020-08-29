# Train class
class Train
  attr_reader :number, :type, :cars, :speed

  #How do you protect parent class from being initialized itself?
  def initialize(number:, type:)
    @number = number
    @type = type
    @cars = []
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

  def attach(car)
    @cars << car if speed.zero? && car.type == type && !cars.include?(car)
  end

  def detach(car)
    cars if speed.zero? && @cars.delete(car) #&& cars.positive?
  end

  private
  # :current is a helper method to get a current station index
  attr_reader :current
end



# TrainCar class
class TrainCar
  attr_reader :type

  def initialize(type:)
    @type = type
  end
end


# TrainCar class
class TrainCar
  attr_reader :type

  def initialize(type:)
    @type = type
  end
end

# PassengerCar class
class PassengerCar < TrainCar

  def initialize
    super(type: :passenger)
  end
end

# CargoCar class
class CargoCar < TrainCar

  def initialize
    super(type: :cargo)
  end
end
