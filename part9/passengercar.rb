# frozen_string_literal: true

# PassengerCar class
class PassengerCar < TrainCar
  attr_reader :number, :available
  @last_number = 0

  def initialize(seats:)
    raise ArgumentError unless seats.is_a?(Integer)

    super(type: :passenger)
    @number = increment_number
    @seats = seats
    @available = seats
  end

  def occupied
    seats - available
  end

  def add_passenger
    raise 'All seats are occupied' if available.zero?

    self.available -= 1
  end

  def remove_passenger
    raise 'No registed passengers' if occupied.zero?

    self.available += 1
  end

  def to_s
    "Car #{number} (available seats: #{available} out of #{seats})"
  end

  private

  attr_reader :seats
  attr_writer :available
end
