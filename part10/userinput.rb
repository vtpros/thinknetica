# frozen_string_literal: true

# UserInput module
module UserInput
  private

  def choose_station_name
    puts "Enter a station's name"
    name = gets.chomp
    return (puts 'Blank name') if name.size.zero?
    return (puts 'Already exists') if station_exists?(name)

    name
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

  def train_info
    type = choose_type
    number = choose_number
    [type, number]
  end

  def choose_type
    print "Train type '0' (passenger) '1' (cargo): "
    type = TYPES[gets.to_i]
    return (puts 'Wrong type') unless type

    type
  end

  def choose_number
    print 'Enter train number: '
    gets.chomp
  end

  def choose_capacity
    print 'Enter the maximum capacity of a cargo car'
    gets.to_i
  end

  def choose_seats
    print 'Enter the maximum number of passenger seats: '
    gets.to_i
  end

  def choose_volume
    print 'Enter a volume to uload'
    gets.to_i
  end

  def choose_direction
    print 'Choose direction: (0) forward, (1) backward: '
    direction = DIRECTIONS[gets.chomp.to_sym]
    return (puts 'Out of range') unless direction

    direction
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

  def choose_train
    trains.each_with_index do |train, index|
      puts "#{index}: #{train.number}"
    end
    print 'Choose a train:'
    train = gets.to_i
    return (puts 'Out of range') if train > trains.size - 1

    train
  end

  def remove_station_info
    print "Route's number: "
    route = gets.to_i
    print "Station's number: "
    station = gets.to_i
    return (puts "Doesn't exist") unless in_range?(station, route)

    [route, station]
  end

  def attach_car_info
    train = choose_train
    return unless train

    case trains[train].type
    when :passenger
      seats = choose_seats
    when :cargo
      capacity = choose_capacity
    end
    [train, seats, capacity]
  end

  def create_route_info
    print 'Origin station number: '
    num1 = gets.to_i
    print 'Destination station number: '
    num2 = gets.to_i
    return (puts 'Not in range') unless in_range?(num1) && in_range?(num2)
    return (puts 'Same station') if num1 == num2

    [all_stations[num1], all_stations[num2]]
  end

  def add_station_info
    print "Route's number: "
    route = gets.to_i
    print "Station's number: "
    station = gets.to_i
    print 'Index to add a station to: '
    index = gets.to_i
    return (puts "Doesn't exist") unless in_range?(station, route)

    [route, station, index]
  end

  def load_cargo_info
    train = choose_train
    return unless train

    print 'Enter a volume to load'
    volume = gets.to_i
    [train, volume]
  end
end
