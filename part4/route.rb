# Route class
class Route
  attr_reader :stations

  def initialize(first:, last:)
    @stations = [first, last]
  end

  def size
    @stations.size
  end

  def [](num)
    @stations[num]
  end

  def add(index, station)
    range = 1..@stations.size - 1
    range.include?(index) ? @stations.insert(index, station) : nil
  end

  def remove(station)
    @stations.include?(station) ? @stations.delete(station) : nil
  end
end
