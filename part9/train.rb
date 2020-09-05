require_relative 'vendor'
require_relative 'resource/train_error_messages'

# Train class
class Train
  include Enumerable
  include Vendor

  MAX_CARS = 10
  @@trains = []

  attr_reader :number, :type, :cars, :speed, :route

  def initialize(number:, type:)
    set_number!(number)
    @type = type
    @cars = []
    @speed = 0
    @@trains << self
  end

  def each_car(&_block)
    cars.each { |car| yield car }
  end

  def route=(route)
    return if @route == route

    @route = route
    @current = 0
    @route.stations[current].receive(self)
  end

  def current_station
    return unless @route

    @route[current]
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
    @route.stations[current + 1].receive(self)
    @current += 1
  end

  def go_backward
    return unless @route && current.positive?

    @route.stations[current].send(self)
    @route.stations[current - 1].receive(self)
    @current -= 1
  end

  def next_station
    @route[current + 1] unless current == @route.size - 1
  end

  def previous_station
    @route[current - 1] if current.nonzero?
  end

  def attach(car)
    @cars << car if can_attach?(car)
  end

  def detach(car)
    cars if speed.zero? && @cars.delete(car)
  end

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def to_s
    "Train #{number}"
  end

  private

  attr_writer :number
  attr_reader :current # current station index

  def set_number!(number)
    raise TypeError, NOT_STRING unless number.is_a?(String)

    number = number.downcase
    raise ArgumentError, INVALID_NUMBER unless valid_number?(number)
    raise ArgumentError, TRAIN_EXISTS if train_exists?(number)

    self.number = number
  end

  def valid_number?(number)
    number =~ /^[a-z\d]{3}-?[a-z\d]{2}$/
  end

  def train_exists?(number)
    @@trains.any? { |train| train.number == number }
  end

  def can_attach?(car)
    speed.zero? && car.type == type && !cars.include?(car) && cars.size < MAX_CARS
  end
end
