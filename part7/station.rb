require_relative 'instancecounter'

# Station class
class Station
  include InstanceCounter

  attr_reader :name, :trains
  @@all = []

  def initialize(name:)
    @name = name
    @trains = []
    register_instance
    @@all << self
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

  def to_s
    name
  end

  def self.all
    @@all
  end
end
