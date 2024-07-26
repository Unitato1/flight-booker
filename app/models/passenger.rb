class Passenger < ApplicationRecord
  # has_many :bookings
  belongs_to :booking
end
