require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'traincar'
require_relative 'passengercar'
require_relative 'cargocar'

# Interface class
class Interface
  TYPES = %i[passenger cargo].freeze
  DIRECTIONS = { '0': :forward, '1': :bakward }.freeze
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
    '10': :move_train,
    '11': :attach_car,
    '12': :detach_car,
    '13': :load_cargo,
    '14': :unload_cargo,
    '15': :add_passenger,
    '16': :remove_passenger,
    '17': :show_cars,
    #'18': :show_trains
    't': :auto_test
  }.freeze

  def initialize
    #@stations = []
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

  def create_railway_station(name: nil)
    if name.nil?
      puts "Enter a station's name"
      name = gets.chomp
      return (puts 'Already exists') if station_exists?(name)
    end

    station = Station.new(name: name)
    puts "Created a station #{station.name}"
    station    
  end

  def existing_stations
    all_stations.each_with_index do |station, index|
      puts "#{index}: #{station}"
    end
  end

  def trains_on_station(station: nil)
    if station.nil?
      station = choose_station
      return unless station
    end

    station = all_stations[station]
    puts 'Trains currently on the station'
    station.each_train { |train| puts train }
  end

  def create_train(type: nil, number: nil)
    if type.nil?
      type = get_type
      return (puts 'Wrong type') if type.nil?

      number = get_number
    end

    train = case type
      when :passenger
        PassengerTrain.new(number: number)
      when :cargo
        CargoTrain.new(number: number)
    end

    @trains << train
    puts "Train #{train.number} (#{train.type}) created"
    train
  rescue ArgumentError => e
    puts e.message
  end

  def create_route(stations: nil)
    if stations.nil?
      print 'Origin station number: '
      num1 = gets.to_i
      print 'Destination station number: '
      num2 = gets.to_i
      return (puts 'Not in range') unless in_range?(num1) && in_range?(num2)
      return (puts 'Same station') if num1 == num2

      stations = [all_stations[num1], all_stations[num2]]
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
    return :error unless @trains[train].route == route

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

    route = @routes[route].add(index, all_stations[station])
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

    route = @routes[route].remove(all_stations[station])
    return (puts 'Station is not in route') unless route

    puts "New route: #{route.map(&:name)}"
  end

  def attach_car(train: nil, seats: nil, capacity: nil)
    if train.nil?
      train = choose_train
      return unless train

      case @trains[train].type
      when :passenger
        seats = get_seats
      when :cargo
        capacity = get_capacity
      end
    end

    train = @trains[train]
    car = case train.type
          when :passenger
            PassengerCar.new(seats: seats)
          when :cargo
            CargoCar.new(capacity: capacity)
          end
    cars = train.attach(car)
    puts "#{cars.last} attached"
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

  # For simplicity it load cargo to the last car
  def load_cargo(train: nil, volume: nil)
    if train.nil?
      train = choose_train
      return unless train

      print 'Enter a volume to load'
      volume = gets.to_i
    end

    car = @trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.load(volume: volume)
  rescue RuntimeError => e
    puts e.message
  end

  # For simplicity it unloads cargo from the last car
  def unload_cargo(train: nil, volume: nil)
    if train.nil?
      train = choose_train
      return unless train

      print 'Enter a volume to uload'
      volume = gets.to_i
    end

    car = @trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.unload(volume: volume)
  rescue RuntimeError => e
    puts e.message
  end

  # For simplicity it adds passenger to the last car
  def add_passenger(train: nil)
    if train.nil?
      train = choose_train
      return unless train
    end

    car = @trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.add_passenger
  rescue RuntimeError => e
    puts e.message
  end

  # For simplicity it removes passenger from the last car
  def remove_passenger(train: nil)
    if train.nil?
      train = choose_train
      return unless train
    end

    car = @trains[train].cars.last
    return (puts 'No cars in the train') if car.nil?

    car.remove_passenger
  rescue RuntimeError => e
    puts e.message
  end

  def show_cars(train: nil)
    train = choose_train if train.nil?

    train = @trains[train]
    return (puts 'No cars in the train') if train.cars.last.nil?

    train.each_car do |car|
      puts car
    end
  end

  def find_train(number:)
    Train.find(number)
  end

  private

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
      10. Move a train
      11. Attach a car to a train
      12. Detach a car from a train
      13: Load cargo
      14: Unload cargo
      15: Add passenger
      16: Remove passenger
      17: Show information about train cars
      Enter' to exit\n
    OPTIONS
  end

  def all_stations
    Station.all
  end

  def station_exists?(name)
    all_stations.any? { |station| station.name == name }
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
    return (puts 'Out of range') if station > stations.size - 1

    station
  end

  def choose_direction
    print 'Choose direction: (0) forward, (1) backward: '
    direction = DIRECTIONS[gets.chomp.to_sym]
    return (puts 'Out of range') unless direction

    direction
  end

  def get_number
    print 'Enter train number: '
    gets.chomp
  end

  def get_type
    print "Train type '0' (passenger) '1' (cargo): "
    n = gets.to_i
    TYPES[n]
  end

  def get_seats
    print 'Enter the maximum number of passenger seats: '
    gets.to_i
  end

  def get_capacity
    print 'Enter the maximum capacity of a cargo car'
    gets.to_i
  end
end
