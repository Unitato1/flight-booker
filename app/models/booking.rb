class Booking < ApplicationRecord
  belongs_to :flight
  # belongs_to :passenger
  has_many :passengers, inverse_of: :booking
  accepts_nested_attributes_for :passengers
end
