require_relative 'instancecounter'

# PassengerTrain class
class PassengerTrain < Train
  include InstanceCounter

  def initialize(number:)
    register_instance
    super(number: number, type: :passenger)
  end
end
