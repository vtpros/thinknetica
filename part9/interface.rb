# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'traincar'
require_relative 'passengercar'
require_relative 'cargocar'
require_relative 'resource/interface_constants'
require_relative 'userinput'
require_relative 'interfacehelper'

# Interface class
class Interface
  include UserInput
  include InterfaceHelper

  def initialize
    @routes = []
  end

  def start
    print_greeting
    print_options

    loop do
      print 'Choose an option or "list" for all the options: '
      answer = gets.chomp.to_sym
      return unless OPTIONS.keys.include?(answer)

      send(OPTIONS[answer])
    end
  end

  def create_railway_station(name: nil)
    name ||= choose_station_name
    return unless name

    station = Station.new(name: name)
    puts "Created a station #{station}"
    station
  end

  def existing_stations
    all_stations.each_with_index do |station, index|
      puts "#{index}: #{station}"
    end
  end

  def trains_on_station(station: nil)
    station ||= choose_station
    return unless station

    station = all_stations[station]
    puts 'Trains currently on the station'
    station.each_train { |train| puts train }
  end

  def create_train(type: nil, number: nil)
    type, number = train_info unless type
    return unless type

    train = PassengerTrain.new(number: number) if type == :passenger
    train = CargoTrain.new(number: number) if type == :cargo

    puts "Train #{train.number} (#{train.type}) created"
    train
  rescue ArgumentError => e
    puts e.message
  end

  def create_route(stations: nil)
    stations ||= create_route_info
    return unless stations

    route = Route.new(first: stations[0], last: stations[1])
    @routes << route
    puts "Created a route #{route.stations.map(&:name)}"
    route
  end

  def existing_routes
    @routes.each_with_index do |route, index|
      puts "#{index}: #{route.stations.map(&:name)}"
    end
  end

  def assign_route(train: nil, route: nil)
    train ||= choose_train
    route ||= choose_route
    route = (trains[train].route = @routes[route])
    return :error unless trains[train].route == route

    puts "Route assigned, next station: #{trains[train].next_station.name}"
  end

  def add_station(route: nil, index: nil, station: nil)
    route, station, index = add_station_info unless route
    return unless route

    route = @routes[route].add(index, all_stations[station])
    return (puts 'Index out of range or station already in route') unless route

    puts "New route: #{route.map(&:name)}"
    route
  end

  def remove_station(route: nil, station: nil)
    route, station = remove_station_info unless route
    return unless route

    route = @routes[route].remove(all_stations[station])
    return (puts 'Station is not in route') unless route

    puts "New route: #{route.map(&:name)}"
  end

  def attach_car(train: nil, seats: nil, capacity: nil)
    train, seats, capacity = attach_car_info unless train
    return unless train

    train = trains[train]
    car = PassengerCar.new(seats: seats) if train.type == :passenger
    car = CargoCar.new(capacity: capacity) if train.type == :cargo
    cars = train.attach(car)
    puts "#{cars.last} attached"
    cars
  end

  def detach_car(train: nil)
    if train.nil?
      train = choose_train
      return unless train
    end

    train = trains[train]
    return (puts 'No cars to detach') if train.cars.empty?

    cars = train.detach(train.cars.last)
    puts "Car detached, #{cars.size} cars left"
    cars
  end

  def move_train(train: nil, direction: nil)
    if train.nil?
      train = choose_train
      direction = choose_direction
      return unless train && direction
    end

    train = trains[train]
    train.go_forward if direction == :forward
    train.go_backward if direction == :bakward
    puts "Train's on the station #{train.current_station.name}."
  end

  # For simplicity it loads cargo to the last car
  def load_cargo(train: nil, volume: nil)
    train, volume = load_cargo_info unless train
    return unless train

    car = trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.load(volume: volume)
  rescue RuntimeError => e
    puts e.message
  end

  # For simplicity it unloads cargo from the last car
  def unload_cargo(train: nil, volume: nil)
    train ||= choose_train
    volume ||= choose_volume
    return unless train

    car = trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.unload(volume: volume)
  rescue RuntimeError => e
    puts e.message
  end

  # For simplicity it adds passenger to the last car
  def add_passenger(train: nil)
    train ||= choose_train
    return unless train

    car = trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.add_passenger
  rescue RuntimeError => e
    puts e.message
  end

  # For simplicity it removes passenger from the last car
  def remove_passenger(train: nil)
    train ||= choose_train
    return unless train

    car = trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.remove_passenger
  rescue RuntimeError => e
    puts e.message
  end

  def show_cars(train: nil)
    train ||= choose_train
    return unless train

    train = trains[train]
    return (puts 'No cars in the train') if train.cars.last.nil?

    train.each_car do |car|
      puts car
    end
  end

  def find_train(number:)
    Train.find(number)
  end
end
