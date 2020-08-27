# Station class
class Station
  attr_reader :name, :trains

  def initialize(name:)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.select { |train| train if train.type == type }
  end

  def receive(train)
    !@trains.include?(train) ? @trains << train : nil
  end

  def send(train)
    @trains.include?(train) ? @trains.delete(train) : nil
  end
end
