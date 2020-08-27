# Route class
class Route
  attr_reader :stations

  NO_STATION = 'No station in route'
  OUT_OF_RANGE = 'Index is out of range'

  def initialize(first:, last:)
    @stations = [first, last]
  end

  def size
    @stations.size
  end

  def [](n)
    @stations[n]
  end

  def add(index, station)
    if (1..@stations.size - 1).include? index
      @stations.insert(index, station)
    else
      OUT_OF_RANGE
    end
  end

  def remove(station)
    @stations.include?(station) ? @stations.delete(station) : NO_STATION
  end
end
