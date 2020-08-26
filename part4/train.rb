# Train class
class Train
  attr_reader :number, :type, :cars, :speed

  @@fail_on_move = "Can't, the train is moving"
  @@fail_on_cars = 'No cars attached'

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

  def go(direction)
    if direction == :backwards
      @current_station.positive? ? @current_station -= 1 : (puts 'No station in route')
    elsif direction == :forward
      @current_station < @route.size - 1 ? @current_station += 1 : (puts 'No station in route')
    end
  end

  def current_station
    puts @route[@current_station]
  end

  def next_station
    if @current_station == @route.size - 1
      puts 'Its the last station'
    else
      puts @route[@current_station + 1]
    end
  end

  def previous_station
    if @current_station.zero?
      puts 'Its the first station'
    else
      puts @route[@current_station - 1]
    end
  end

  def attach
    speed.zero? ? @cars += 1 : (puts @@fail_on_move)
  end

  def detach
    if speed.zero?
      @cars.positive? ? @cars -= 1 : (puts @@fail_on_cars)
    else
      puts @@fail_on_move
    end
  end
end
