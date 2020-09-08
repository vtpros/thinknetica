# frozen_string_literal: true

require_relative 'instancecounter'

# PassengerTrain class
class PassengerTrain < Train
  include InstanceCounter

  def initialize(number:)
    super(number: number, type: :passenger)
    register_instance
  end
end
