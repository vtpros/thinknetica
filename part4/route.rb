# Route class
class Route
  def initialize(first:, last:)
    @route = [first, last]
  end

  def size
    @route.size
  end

  def [](n)
    @route[n]
  end

  def add(ind, station)
    case ind
    when 1..@route.size - 1
      @route.insert(ind, station)
    else puts 'Out of range'
    end
  end

  def remove(station)
    @route.include?(station) ? @route.delete(station) : (puts 'No station in route')
  end

  def stations
    @route.each { |station| puts station }
  end
end
