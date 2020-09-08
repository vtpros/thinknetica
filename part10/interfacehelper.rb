# frozen_string_literal: true

# Interface helper methods module
module InterfaceHelper
  private

  def print_greeting
    puts "This is a railways manager interface\nAvailable options:\n\n"
  end

  def print_options
    puts OPTIONS_TEXT
  end

  def all_stations
    Station.all
  end

  def trains
    Train.all
  end

  def station_exists?(name)
    all_stations.any? { |station| station.name == name }
  end

  def in_range?(station_num, route_num = nil)
    station_num < all_stations.size && !(route_num >= @routes.size if route_num)
  end
end
