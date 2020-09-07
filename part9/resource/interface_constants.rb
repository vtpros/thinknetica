# frozen_string_literal: true

# Define constants for Interface class

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
  't': :auto_test
}.freeze
OPTIONS_TEXT = <<~OPTIONS
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
  'Enter' to exit
OPTIONS
