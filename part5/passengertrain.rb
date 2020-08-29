# PassengerTrain class
class PassengerTrain < Train

  def initialize(number:)
    super(number: number, type: :passenger)
  end
end
