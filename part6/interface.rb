require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'traincar'
require_relative 'passengercar'
require_relative 'cargocar'
require_relative 'test'

# Interface class
class Interface
  TYPES = %i[passenger cargo].freeze
  DIRECTIONS = {
    '0': :forward,
    '1': :bakward
  }.freeze
  OPTIONS = {
    'list': :print_options,
    '1': :create_railway_station,
    '2': :existing_stations,
    '3': :trains_on_station,
    '4': :create_train,
    '5': :create_route,
    '6': :existing_routes,
    '7': :assign_route,
    '8': :add_station,
    '9': :remove_station,
    '10': :attach_car,
    '11': :detach_car,
    '12': :move_train,
    't': :auto_test
  }.freeze

  def all_stations
    Station.all
  end

  def initialize
    @stations = []
    @routes = []
    @trains = []
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

  # It will be hard to test it with Rpsec without direct access to methods
  # private

  def print_greeting
    puts "This is a railways manager interface\nAvailable options:\n\n"
  end

  def print_options
    puts <<~OPTIONS
      1. Create a new railway station
      2. See existing railway stations
      3. See all trains on a station
      4. Create a train
      5. Create a route
      6. See existing routes
      7. Assign a route to a train
      8. Add a station to a route
      9. Remove a station from a route
      10. Attach a car to a train
      11. Detach a car from a train
      12. Move a train
      'Enter' to exit\n
    OPTIONS
  end

  def station_exist?(name)
    all_stations.any? { |station| station.name == name }
  end

  def train_exist?(number)
    @trains.any? { |station| station.number == number }
  end

  def in_range?(station_num, route_num = nil)
    station_num < all_stations.size && !(route_num >= @routes.size if route_num)
  end

  def choose_train
    @trains.each_with_index do |train, index|
      puts "#{index}: #{train.number}"
    end
    print 'Choose a train:'
    train = gets.to_i
    return (puts 'Out of range') if train > @trains.size - 1

    train
  end

  def choose_route
    @routes.each_with_index do |route, index|
      puts "#{index}: #{route.stations.map(&:name)}"
    end
    print 'Choose a route:'
    route = gets.to_i
    return (puts 'Out of range') if route > @routes.size - 1

    route
  end


  def choose_station
    stations = all_stations
    stations.each_with_index do |station, index|
      puts "#{index}: #{station}"
    end
    print 'Choose a station:'
    station = gets.to_i
    return (puts 'Out of range') if station > stations.all - 1

    station
  end

  def choose_direction
    print 'Choose direction: (0) forward, (1) backward: '
    direction = DIRECTIONS[gets.chomp.to_sym]
    return (puts 'Out of range') unless direction

    direction
  end

  def create_railway_station(name: nil)
    if name.nil?
      puts "Enter a station's name"
      name = gets.chomp
      return (puts 'Already exists') if station_exist?(name)
    end

    @stations << Station.new(name: name)
    puts "Created a station #{@stations.last.name}"
    @stations.last
  end

  def existing_stations
    stations = Station.all
    stations.each_with_index do |station, index|
      puts "#{index}: #{station}"
    end
  end

  def trains_on_station(station: nil)
    if station.nil?
      station = choose_station
      return unless station
    end
    puts "Trains here: #{@stations[station].trains.map(&:number)}"
  end

  def create_train(type: nil, number: nil)
    if type.nil?
      print 'Enter train number: '
      number = gets.to_i
      print "Train type '0' (passenger) '1' (cargo): "
      type = TYPES[gets.to_i]
      return (puts 'Try again') if type.nil? || number.zero? || train_exist?(number)
    end

    train = case type
            when :passenger
              PassengerTrain.new(number: number)
            when :cargo
              CargoTrain.new(number: number)
            end
    @trains << train
    puts "Train #{train.number}, #{train.type} created"
    train
  end

  def create_route(stations: nil)
    if stations.nil?
      print 'Origin station number: '
      num1 = gets.to_i
      print 'Destination station number: '
      num2 = gets.to_i
      return (puts 'Not in range') unless in_range?(num1) && in_range?(num2)
      return (puts 'Same station') if num1 == num2

      stations = [@stations[num1], @stations[num2]]
    end

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
    if train.nil?
      train = choose_train
      route = choose_route
      return unless route && train
    end

    route = (@trains[train].route = @routes[route])

    # Since invoking setter returns right hand value instead of what the setter
    # method axtually returns (it's nil here), this will never be executed
    # Don't know how can I catch failed setter
    return (puts 'Failed') unless route

    puts "Route assigned, next station: #{@trains[train].next_station.name}"
  end

  def add_station(route: nil, index: nil, station: nil)
    if route.nil?
      print "Route's number: "
      route = gets.to_i
      print "Station's number: "
      station = gets.to_i
      print 'Index to add a station to: '
      index = gets.to_i

      return (puts "Doesn't exist") unless in_range?(station, route)
    end

    route = @routes[route].add(index, @stations[station])
    return (puts 'Index out of range or station already in route') unless route

    puts "New route: #{route.map(&:name)}"
    route
  end

  def remove_station(route: nil, station: nil)
    if route.nil?
      print "Route's number: "
      route = gets.to_i
      print "Station's number: "
      station = gets.to_i
      return (puts "Doesn't exist") unless in_range?(station, route)
    end

    route = @routes[route].remove(@stations[station])
    return (puts 'Station is not in route') unless route

    puts "New route: #{route.map(&:name)}"
  end

  def attach_car(train: nil)
    if train.nil?
      train = choose_train
      return unless train
    end

    train = @trains[train]
    car = case train.type
          when :passenger
            PassengerCar.new
          when :cargo
            CargoCar.new
          end
    cars = train.attach(car)
    puts "#{cars.last} attached"
    #puts "#{train.attach(car).last} attached"
    cars
  end

  def detach_car(train: nil)
    if train.nil?
      train = choose_train
      return unless train
    end

    train = @trains[train]
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
      #to implement
    end

    train = @trains[train]

    case direction
    when :forward
      train.go_forward
    when :bakward
      train.go_backward
    end
    puts "Train's on the station #{train.current_station.name}."
  end

  def find_train(number:)
    Train.find(number)
  end
end
