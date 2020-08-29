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
    return unless (1..stations.size - 1).include?(index) && !stations.include?(station)
    @stations.insert(index, station)
  end

  def remove(station)
    stations if @stations.delete(station) && stations.size >= 2
  end
end
