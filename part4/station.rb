# Station class
class Station
  attr_reader :name, :trains

  NOT_PRESENT = 'Train is not on the station'
  ALREADY_PRESENT = 'Train is already on the station'

  def initialize(name:)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.select { |train| train if train.type == type }
  end

  def receive(train)
    !@trains.include?(train) ? @trains << train : ALREADY_PRESENT
  end

  def send(train)
    @trains.include?(train) ? @trains.delete(train) : NOT_PRESENT
  end
end
