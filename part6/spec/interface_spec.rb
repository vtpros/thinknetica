require '../interface'
require 'stringio'

interface = Interface.new

describe Interface do  

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

  it "should create a station via user input'" do
    interface.stub(:gets) { "Earth\n" }
    expect(interface).to receive(:puts).with("Enter a station's name")
    expect(interface).to receive(:puts).with('Created a station Earth')
    interface.create_railway_station
  end

  it "should not create a station with the same name via user input'" do
    interface.stub(:gets) { "Kolyma\n" }
    expect(interface).to receive(:puts).with("Enter a station's name")
    expect(interface).to receive(:puts).with('Already exists')
    interface.create_railway_station
  end

  it 'should print a list of stations' do
    expect(interface.existing_stations).to eq Station.all
  end

  it "should create routes" do
    routes = [[0, 1], [2, 3]]
    stations = Station.all
    route = nil
    2.times do |index|
      route = interface.create_route( stations: [ stations[routes[index][0]], stations[routes[index][1]] ] )
    end
    expect(route).to be_instance_of Route
  end

  it 'should return Route.instances counter' do
    expect(Route.instances).to eq 2
  end

  it "show existing routes" do
    expect(interface).to receive(:puts).with('0: ["New vasyuki", "Old vasyuki"]')
    expect(interface).to receive(:puts).with('1: ["Gadyukino", "Kolyma"]')
    routes = interface.existing_routes
  end

  it "add a station to a route" do
    expect(interface).to receive(:puts).with('New route: ["New vasyuki", "Gadyukino", "Old vasyuki"]')
    interface.add_station(route: 0, index: 1, station: 2)
  end

  it "should remove a station" do
    expect(interface).to receive(:puts).with('New route: ["New vasyuki", "Old vasyuki"]')
    interface.remove_station(route: 0, station: 2)
  end

  it "should create cargo train" do
    train = interface.create_train(type: :cargo, number: '200')
    expect(train).to be_instance_of CargoTrain
  end

  it "should create passenger train" do
    train = interface.create_train(type: :passenger, number: '404')
    expect(train).to be_instance_of PassengerTrain
  end

  it 'should return Train.instances counter' do
    expect(CargoTrain.instances).to eq 1
    expect(PassengerTrain.instances).to eq 1
  end

  it "find a cargo train" do
    train = interface.find_train(number: '200')
    expect(train).to be_instance_of CargoTrain
    expect(train.number).to eq '200'
  end

  it "find a passenger train" do
    train = interface.find_train(number: '404')
    expect(train).to be_instance_of PassengerTrain
    expect(train.number).to eq '404'
  end

  it "should not return a train vendor if not set" do
    train = interface.find_train(number: '404')
    expect(train.vendor).to eq nil
  end

  it "should set and return train vendor" do
    train = interface.find_train(number: '404')
    train.vendor = 'Lada'
    expect(train.vendor).to eq 'Lada'
  end

  it "attach and set vendor to cargo cars" do
    cars = interface.attach_car(train: 0)
    car = cars.last
    car.vendor = 'Lada'
    expect(car).to be_instance_of CargoCar
    expect(car.vendor).to eq 'Lada'
  end

  it "attach and set vendor to passenger cars" do
    cars = interface.attach_car(train: 1)
    car = cars.last
    car.vendor = 'Lada'
    expect(car).to be_instance_of PassengerCar
    expect(car.vendor).to eq 'Lada'
  end

  it "should do smth" do
    expect(1).to eq 1
  end
end
