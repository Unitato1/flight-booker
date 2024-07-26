# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
airports = ["SFO", "NYC", "KE", "BA"]
airports.each do |airport_code|
  Airport.find_or_create_by!(code: airport_code)
end

def random_datetime(start_date = DateTime.now, end_date = DateTime.now + 365)
  time_diff = end_date.to_time - start_date.to_time
  random_time = start_date.to_time + rand * time_diff
  random_time.to_datetime
end

def random_interval
  # days = rand(0..10)
  hours = rand(1..23)
  minutes = rand(1..59)
  seconds = rand(1..59)
  "#{hours} hours #{minutes} minutes #{seconds} seconds"
end
i = Airport.first.id
airports.reverse.each do |airport|
  obj_air = Airport.find_or_create_by!(code: airport)
  obj_air_start = Airport.find_or_create_by!(id: i)
  obj_air.arriving_flights.find_or_create_by!(start: random_datetime, duration: random_interval, departure_airport_id: obj_air_start.id)
  obj_air_start.departing_flights.find_or_create_by!(start: random_datetime, duration: random_interval, arrival_airport_id: obj_air.id)
  i += 1
end
