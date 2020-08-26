require_relative './station'
require_relative './route'
require_relative './train'

puts 'Creating several stations'
station1 = Station.new(name: 'New vasyuki')
station2 = Station.new(name: 'Old vasyuki')
station3 = Station.new(name: 'Gadyukino')
station4 = Station.new(name: 'Kolyma')

puts 'Creating several trains'
train1 = Train.new(number: '404', type: :passenger, cars: 1)
train2 = Train.new(number: '200', type: :passenger, cars: 2)
train3 = Train.new(number: '501', type: :cargo, cars: 1)
train4 = Train.new(number: '451', type: :cargo, cars: 10)

puts 'Train number:'
puts "Number: #{train1.number}, should be 404"

puts 'Number of cars:'
puts "Cars: #{train1.cars}, should be 1"

puts 'Accelerating the train:'
train1.accelerate
puts "Speed: #{train1.speed}, should be 5"

puts 'Expecting to fail on detaching a car:'
train1.detach

puts 'Expecting to fail on attaching a car:'
train1.detach

puts 'Stopping a train'
train1.stop

puts 'Expecting to fail on detaching 2 cars - only one is attached:'
train1.detach
train1.detach

puts 'Creating new route:'
route1 = Route.new(
  first: station1,
  last: station2
)

puts 'Adding a new station'
route1.add(1, station3)

puts 'Display all stations in a route:'
route1.stations

puts 'Expecting to fail on adding a station as origin or out of route size'
route1.add(0, station4)
route1.add(3, station4)

puts 'Removing a station'
route1.remove(station3)

puts 'Expecting to fail on removing station not in route'
route1.remove(station4)

puts 'Passing the route to the train'
train1.route = route1

puts 'Current station:'
train1.current_station

puts 'Next station:'
train1.next_station

puts 'Expecting to fail on showing previous station while on the first:'
train1.previous_station

puts 'Expecting to fail on going backwards while on the first station'
train1.go(:backwards)

puts 'Going forward'
train1.go(:forward)

puts 'Expecting to fail on going forward if on the last station'
train1.go(:forward)

puts 'Expecting to fail on showing next station while on last:'
train1.next_station

puts 'Station receives some trains'
station1.receive(train1)
station1.receive(train2)
station1.receive(train3)
station1.receive(train4)

puts 'Displaying trains on the station'
station1.trains

puts 'Displaying passenger trains'
station1.trains_by_type(:passenger)

puts 'Displaying cargo trains'
station1.trains_by_type(:cargo)

puts 'Station sends the train'
station1.send(train1)

puts 'Expecting to fail on sending a train that is not on the station'
station1.send(train1)
