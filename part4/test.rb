require_relative './station'
require_relative './route'
require_relative './train'

puts 'Creating several stations'
p (station1 = Station.new(name: 'New vasyuki')).name
p (station2 = Station.new(name: 'Old vasyuki')).name
p (station3 = Station.new(name: 'Gadyukino')).name
p (station4 = Station.new(name: 'Kolyma')).name

puts 'Creating several trains'
p (train1 = Train.new(number: '404', type: :passenger, cars: 1)).number
p (train2 = Train.new(number: '200', type: :passenger, cars: 2)).number
p (train3 = Train.new(number: '501', type: :cargo, cars: 1)).number
p (train4 = Train.new(number: '451', type: :cargo, cars: 10)).number

puts 'Train number:'
puts "Number: #{train1.number}, should be 404"

puts 'Number of cars:'
puts "Cars: #{train1.cars}, should be 1"

puts 'Accelerating the train:'
p train1.accelerate
puts "Speed: #{train1.speed}, should be 5"

puts 'Expecting to fail on detaching a car:'
p train1.detach

puts 'Expecting to fail on attaching a car:'
p train1.detach

puts 'Stopping a train'
p train1.stop

puts 'Expecting to fail on detaching 2 cars - only one is attached:'
p train1.detach
p train1.detach

puts 'Creating new route:'
route1 = Route.new(
  first: station1,
  last: station2
)
p route1.stations.map { |station| station.name}

puts 'Adding a new station'
p route1.add(1, station3).map { |station| station.name}

puts 'Display all stations in a route:'
p route1.stations.map { |station| station.name}

puts 'Expecting to fail on adding a station as origin or out of route size'
p route1.add(0, station4)
p route1.add(3, station4)

puts 'Removing a station'
p route1.remove(station3).name

puts 'Expecting to fail on removing station not in route'
p route1.remove(station4)

puts 'Passing the route to the train'
p (train1.route = route1).stations.map { |station| station.name}

puts 'Current station:'
p train1.current_station.name

puts 'Next station:'
p train1.next_station.name

puts 'Expecting to fail on showing previous station while on the first:'
p train1.previous_station

puts 'Expecting to fail on going backward while on the first station'
p train1.go_backward

puts 'Going forward, backward and forward again'
p train1.go_forward
p train1.go_backward
p train1.go_forward

puts 'Expecting to fail on going forward if on the last station'
p train1.go_forward

puts 'Expecting to fail on showing next station while on last:'
p train1.next_station

puts 'Station receives some trains'
p station1.receive(train1).map { |train| train.number}
p station1.receive(train2).map { |train| train.number}
p station1.receive(train3).map { |train| train.number}
p station1.receive(train4).map { |train| train.number}
puts 'Expecting to fail on receiving a train present'
p station1.receive(train4)

puts 'Displaying trains on the station'
p station1.trains.map { |train| train.number}

puts 'Displaying passenger trains'
p station1.trains_by_type(:passenger).map { |train| train.number}

puts 'Displaying cargo trains'
p station1.trains_by_type(:cargo).map { |train| train.number}

puts 'Station sends the train'
p station1.send(train1).number

puts 'Expecting to fail on sending a train that is not on the station'
p station1.send(train1)
