require_relative 'instancecounter'

# Station class
class Station
  include Enumerable
  include InstanceCounter

  attr_reader :name, :trains
  @@stations = []

  def initialize(name:)
    @name = name
    @trains = []
    register_instance
    @@stations << self
  end

  def each_train(&_block)
    trains.each { |train| yield train }
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def receive(train)
    @trains << train unless train_on_station?(train)
  end

  def send(train)
    @trains.delete(train) if train_on_station?(train)
  end

  def to_s
    name
  end

  def self.all
    @@stations
  end

  private

  def train_on_station?(train)
    trains.include?(train)
  end
end
