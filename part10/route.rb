# frozen_string_literal: true

require_relative 'instancecounter'
require_relative 'validation'

# Route class
class Route
  include InstanceCounter
  include Validation
  attr_reader :stations

  def initialize(first:, last:)
    validate!(value: first, validation_type: :type, arg: Station)
    validate!(value: last, validation_type: :type,  arg: Station)
    register_instance
    @stations = [first, last]
  end

  def size
    stations.size
  end

  def [](num)
    stations[num]
  end

  def add(index, station)
    validate!(value: station, validation_type: :type, arg: Station)
    return unless route_valid?(index, station)

    @stations.insert(index, station)
  end

  def remove(station)
    stations if stations.size > 2 && @stations.delete(station)
  end

  private

  def route_valid?(index, station)
    (1..stations.size - 1).include?(index) && !stations.include?(station)
  end
end
