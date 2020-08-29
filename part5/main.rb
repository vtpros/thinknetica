require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passengertrain'
require_relative 'cargotrain'
require_relative 'traincar'
require_relative 'passengercar'
require_relative 'cargocar'
require_relative 'test'

# What I still need to do:
#
# detach a car (just started)
#
# assign a route to a train - when I assing a route, I have to  invoke
# Station.recive method to put a train in a train list. And I imagine
# I have to add it to the list of available options too.
#
# move a train -I want to show user the existing trains and
# existing stations for him to choose from. Then I have to invoke
# Station.send and Station.receive
#
# see all the trains on a station - simple Station.trains method
#
# Also I implemented 'attach a car' method to simply create a new car
# and attach it to the train. Don't know if it's ok

def print_greeting
  puts "This is a railways manager interface\nAvailable options:\n\n"
end

def print_options
  puts <<~EOL
  1. Create a new railway station
  2. See existing railway stations
  3. See all trains on a station
  4. Create a train
  5. Create a route
  6. See existing routes
  7. Add a station to a route
  8. Remove a station from a route
  9. Attach a car to a train
  10. Detach a car from a train
  11. Move a train
  'Enter' to exit\n
  EOL
end

options = {
  'list': :print_options,
  '1': :create_railway_station,
  '2': :existing_stations,
  '3': :trains_on_station,
  '4': :create_train,
  '5': :create_route,
  '6': :existing_routes,
  '7': :add_station,
  '8': :remove_station,
  '9': :attach_car,
  '10': :detach_car,
  '11': :move_train,
  't': :auto_test
}

@stations = []
@routes = []
@trains = []
@cars = []

def station_exist?(name)
  @stations.any?{ |station| station.name == name }
end

def in_range?(station_num, route_num = nil)
  station_num < @stations.size && !(route_num >= @routes.size if route_num)
end

def create_railway_station(name: nil)
  if name.nil?
    puts "Enter a stations name"
    name = gets.chomp
    return (puts 'Already exists') if station_exist?(name)
  end

  @stations << Station.new(name: name)
  puts "Created a station #{@stations.last.name}"
end

def existing_stations
  @stations.each_with_index do |station, index|
    puts "#{index}: #{station.name}"
  end
end

def trains_on_station
end

def create_train(type: nil, number: nil)
  if type.nil?
    return
  end

  train = case type
          when :passenger
            PassengerTrain.new(number: number)
          when :cargo
            CargoTrain.new(number: number)
          end
  @trains << train
  puts "Train #{train.number}, #{train.type}"
end

def create_route(stations: nil)
  if stations.nil?
    print 'Origin station number: '
    num1 = gets.to_i
    print 'Destination station number: '
    num2 = gets.to_i
    return (puts "Not in range") unless in_range?(num1) && in_range?(num2)
    return (puts "Same station") if num1 == num2

    stations = [@stations[num1], @stations[num2]]
  end

  @routes << Route.new(first: stations[0], last: stations[1])
  puts "Created a route #{@routes.last.stations.map(&:name)}"
end

def existing_routes
  @routes.each_with_index do |route, index|
    puts "#{index}: #{route.stations.map(&:name)}"
  end
end

def add_station(route: nil, index: nil, station: nil)
  if route.nil?
    print "Route's number: "
    route = gets.to_i
    #p in_r_range?(route)
    print "Station's number: "
    station = gets.to_i
    #p in_s_range?(station)
    print 'Index to add a station to: '
    index = gets.to_i

    return (puts "Doesn't exist") unless in_range?(station, route)
  end


  route = @routes[route].add(index, @stations[station])
  return (puts 'Index out of range or station already in route') unless route
  puts "New route: #{route.map(&:name)}"

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

def attach_car(train = nil)
  if train.nil?
    return
  end

  train = @trains[train]
  car = case train.type
        when :passenger
          PassengerCar.new
        when :cargo
          CargoCar.new
        end
  @cars << train.attach(car).last
  p @cars.last
end

def detach_car(train: nil, car: nil )
  if train.nil?
    return
  end

  train = @trains[train]
  case train.type
  when :passenger

  when :cargo

  end
end

def move_train
end

print_greeting
print_options

loop do
  print 'Choose an option or "list" for the options list: '
  answer = gets.chomp.to_sym
  return unless options.keys.include?(answer)

  send(options[answer])
end
