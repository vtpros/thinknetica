def auto_test
  puts "\n"
  puts 'Creating several stations'
  puts '======='
  create_railway_station(name: 'New vasyuki')
  create_railway_station(name: 'Old vasyuki')
  create_railway_station(name: 'Gadyukino')
  create_railway_station(name: 'Kolyma')

  puts "\n"
  puts 'Showing existing stations'
  puts '======='
  existing_stations

  #create_route
  puts "\n"
  puts 'Creating several routes'
  puts '======='
  create_route(stations: [@stations[0], @stations[1]])
  create_route(stations: [@stations[2], @stations[3]])

  puts "\n"
  puts 'Showing existing routes'
  puts '======='
  existing_routes

  #add_station
  puts "\n"
  puts 'Adding a station to a route'
  puts '======='
  add_station(route: 0, index: 1, station: 2)
  add_station(route: 1, index: 1, station: 1)
  puts "Can't add existing station:"
  add_station(route: 0, index: 1, station: 2)
  puts "Can't add station out of index:"
  add_station(route: 1, index: 2, station: 3)

  #remove_station
  puts "\n"
  puts 'Removing a station from a route'
  puts '======='
  remove_station(route: 0, station: 2)
  remove_station(route: 1, station: 2)
  puts "Can't remove if not in route:"
  remove_station(route: 1, station: 0)
  puts "Can't remove if 2 stations left:"
  remove_station(route: 0, station: 0)

  #create_train
  puts "\n"
  puts 'Creating some trains'
  puts '======='
  create_train(type: :passenger, number: '404')
  create_train(type: :cargo, number: '200')

  #attach_car
  puts "\n"
  puts 'Attaching some cars'
  puts '======='
  attach_car(train: 0)
  attach_car(train: 0)
  attach_car(train: 1)
  attach_car(train: 1)

  #detach_car
  puts "\n"
  puts 'Detaching some cars'
  puts '======='
  detach_car(train: 0)
  detach_car(train: 0)
  puts 'Fail on detaching if no cars left'
  detach_car(train: 0)

  #assign_route; gets
  puts "\n"
  puts 'Attaching some routes'
  puts '======='
  assign_route(train: 0, route: 0)
  assign_route(train: 1, route: 1)
  puts 'Trying to assign same route to the train: '
  assign_route(train: 1, route: 1)

  puts "\n"
  puts 'List of all the trains on a station'
  puts '======='
  trains_on_station(station: 0)
  puts 'No trains should be here'
  trains_on_station(station: 2)

  puts "\n"
  puts 'Move train'
  puts '======='
  move_train
end
