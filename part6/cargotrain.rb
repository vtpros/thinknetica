require_relative 'instancecounter'

# CargoTrain class
class CargoTrain < Train
  include InstanceCounter

  def initialize(number:)
    register_instance
    super(number: number, type: :cargo)
  end
end
