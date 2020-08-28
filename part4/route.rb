# Route class
class Route
  attr_reader :stations

  def initialize(first:, last:)
    @stations = [first, last]
  end

  def size
    stations.size
  end

  def [](num)
    stations[num]
  end

  def add(index, station)
    @stations.insert(index, station) if (1..stations.size - 1).include?(index)
  end

  def remove(station)
    @stations.delete(station)
  end
end
