require_relative 'instancecounter'

# CargoTrain class
class CargoTrain < Train
  include InstanceCounter

  def initialize(number:)
    super(number: number, type: :cargo)
    register_instance
  end
end
