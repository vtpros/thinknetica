require_relative '../interface'
require 'stringio'

interface = Interface.new

describe Interface do
  it 'should return zero instances counters when nothing is created' do
    expect(Station.instances).to eq 0
    expect(PassengerTrain.instances).to eq 0
    expect(CargoTrain.instances).to eq 0
    expect(Route.instances).to eq 0
  end

  it 'should create railway stations' do
    names = %w[New\ vasyuki Old\ vasyuki Gadyukino Kolyma]
    stations = []

    4.times do |index|
      stations << interface.create_railway_station(name: names[index])
    end

    expect(stations).to eq Station.all
  end

  it 'should return Station.instances counter' do
    expect(Station.instances).to eq 4
  end

  it 'should create a station via user input' do
    interface.stub(:gets) { "Earth\n" }
    expect(interface).to receive(:puts).with("Enter a station's name")
    expect(interface).to receive(:puts).with('Created a station Earth')
    interface.create_railway_station
  end

  it 'should not create a station with the same name via user input' do
    interface.stub(:gets) { "Kolyma\n" }
    expect(interface).to receive(:puts).with("Enter a station's name")
    expect(interface).to receive(:puts).with('Already exists')
    interface.create_railway_station
  end

  it 'should print a list of stations' do
    expect(interface.existing_stations).to eq Station.all
  end

  it 'should create routes' do
    routes = [[0, 1], [2, 3]]
    stations = Station.all
    route = nil
    2.times do |index|
      route = interface.create_route(stations: [stations[routes[index][0]], stations[routes[index][1]]])
    end
    expect(route).to be_instance_of Route
  end

  it 'should return Route.instances counter' do
    expect(Route.instances).to eq 2
  end

  it 'show existing routes' do
    expect(interface).to receive(:puts).with('0: ["New vasyuki", "Old vasyuki"]')
    expect(interface).to receive(:puts).with('1: ["Gadyukino", "Kolyma"]')
    interface.existing_routes
  end

  it 'add a station to a route' do
    expect(interface).to receive(:puts).with('New route: ["New vasyuki", "Gadyukino", "Old vasyuki"]')
    interface.add_station(route: 0, index: 1, station: 2)
  end

  it 'should remove a station' do
    expect(interface).to receive(:puts).with('New route: ["New vasyuki", "Old vasyuki"]')
    interface.remove_station(route: 0, station: 2)
  end

  it 'should create cargo train' do
    trains = []
    numbers = %w[zzz-zz zzzzz 1aa-a2]
    numbers.each do |number|
      trains << interface.create_train(type: :cargo, number: number)
    end
    expect(trains.last).to be_instance_of CargoTrain
  end

  it 'should create passenger train' do
    trains = []
    numbers = %w[1aaa2 235-54 23554]
    numbers.each do |number|
      trains << interface.create_train(type: :passenger, number: number)
    end
    expect(trains.last).to be_instance_of PassengerTrain
  end

  it 'should fail to create the train with invalid number' do
    train = interface.create_train(type: :passenger, number: 'aaa')
    expect(train).to eq :error
  end

  it 'should fail to create the train with a same name via user.input' do
    interface.stub(:gets) { "zzz-zz\n" }
    expect(interface).to receive(:puts).with('Train with this number already exists')
    interface.create_train
  end

  it 'should fail to create the train with wrong type via user input' do
    interface.stub(:gets) { "2\n" }
    expect(interface).to receive(:puts).with('Wrong type')
    interface.create_train
  end

  it 'should return Train.instances counter' do
    expect(CargoTrain.instances).to eq 3
    expect(PassengerTrain.instances).to eq 3
  end

  it 'should find a cargo train' do
    train = interface.find_train(number: '1aa-a2')
    expect(train).to be_instance_of CargoTrain
    expect(train.number).to eq '1aa-a2'
  end

  it 'should find a passenger train' do
    train = interface.find_train(number: '23554')
    expect(train).to be_instance_of PassengerTrain
    expect(train.number).to eq '23554'
  end

  it 'should not return a train vendor if not set' do
    train = interface.find_train(number: '1aa-a2')
    expect(train.vendor).to eq nil
  end

  it 'should set and return train vendor' do
    train = interface.find_train(number: '1aa-a2')
    train.vendor = 'Lada'
    expect(train.vendor).to eq 'Lada'
  end

  it 'should attach and set vendor to cargo cars' do
    cars = interface.attach_car(train: 0)
    car = cars.last
    car.vendor = 'Lada'
    expect(car).to be_instance_of CargoCar
    expect(car.vendor).to eq 'Lada'
  end

  it 'should attach and set vendor to passenger cars' do
    cars = interface.attach_car(train: 3)
    car = cars.last
    car.vendor = 'Lada'
    expect(car).to be_instance_of PassengerCar
    expect(car.vendor).to eq 'Lada'
  end
end
