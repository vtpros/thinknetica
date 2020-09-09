# frozen_string_literal: true

require_relative 'vendor'
require_relative 'validation'
require_relative 'resource/train_error_messages'

# Train class
class Train
  include Enumerable
  include Vendor
  include Validation

  MAX_CARS = 10
  NUMBER_REGEX = /^[a-z\d]{3}-?[a-z\d]{2}$/.freeze
  @all = []

  class << self
    attr_reader :all
  end

  attr_reader :number, :type, :cars, :speed, :route

  def initialize(number:, type:)
    validate!(value: number, validation_type: :presence)
    validate!(value: number, validation_type: :type, arg: String)
    validate!(value: number, validation_type: :format, arg: NUMBER_REGEX)
    # I don't know how to put it in Validation to get a sensible error message
    validate_existance!(number)
    @number = number
    @type = type
    @cars = []
    @speed = 0
    Train.all << self
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
    Train.all.find { |train| train.number == number }
  end

  def to_s
    "Train #{number}"
  end

  private

  attr_reader :current # current station index

  def validate_existance!(number)
    raise ArgumentError, TRAIN_EXISTS if train_exists?(number)

    number
  end

  def train_exists?(number)
    Train.all.any? { |train| train.number == number }
  end

  def can_attach?(car)
    speed.zero? && car.type == type && !cars.include?(car) && cars.size < MAX_CARS
  end
end
