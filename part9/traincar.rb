require_relative 'vendor'

# TrainCar class
class TrainCar
  include Vendor

  attr_reader :type

  def initialize(type:)
    @type = type
  end
end
