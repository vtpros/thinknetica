# frozen_string_literal: true

require_relative 'vendor'

# TrainCar class
class TrainCar
  include Vendor

  attr_reader :type

  def initialize(type:)
    @type = type
  end

  private

  def increment_number
    last_number = self.class.instance_variable_get '@last_number'
    self.class.instance_variable_set '@last_number', last_number + 1
  end
end
