# frozen_string_literal: true

# CargoCar class
class CargoCar < TrainCar
  attr_reader :number, :available
  @last_number = 0

  def initialize(capacity:)
    raise ArgumentError unless capacity.is_a?(Integer)

    super(type: :cargo)
    @number = increment_number
    @capacity = capacity
    @available = capacity
  end

  def occupied
    capacity - available
  end

  def load(volume:)
    raise 'More than available volume' if volume > available

    self.available -= volume
  end

  def unload(volume:)
    raise 'More than occupied volume' if volume > occupied

    self.available += volume
  end

  def to_s
    "Car #{number} (available volume: #{available} out of #{capacity})"
  end

  private

  attr_reader :capacity
  attr_writer :available
end
