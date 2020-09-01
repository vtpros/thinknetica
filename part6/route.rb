require_relative 'instancecounter'

# Route class
class Route
  include InstanceCounter
  attr_reader :stations

  def initialize(first:, last:)
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
    return unless (1..stations.size - 1).include?(index) && !stations.include?(station)

    @stations.insert(index, station)
  end

  def remove(station)
    stations if stations.size > 2 && @stations.delete(station)
  end
end
