# Station class
class Station
  attr_reader :name, :trains

  def initialize(name:)
    @name = name
    @trains = []
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def receive(train)
    @trains << train unless trains.include?(train)
  end

  def send(train)
    @trains.delete(train) if trains.include?(train)
  end
end
