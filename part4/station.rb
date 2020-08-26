# Station class
class Station
  attr_reader :name

  def initialize(name:)
    @name = name
    @trains = []
  end

  def trains
    @trains.each do |train|
      puts train
    end
  end

  def trains_by_type(type)
    @trains.each do |train|
      puts train if train.type == type
    end
  end

  def receive(train)
    @trains << train
  end

  def send(train)
    @trains.include?(train) ? @trains.delete(train) : (puts 'Not on the station')
  end
end
