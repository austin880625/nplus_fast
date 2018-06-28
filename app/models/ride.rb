class Ride < ApplicationRecord
  validates_presence_of :title, :time_start, :time_end, :from, :to, :vehicle
  has_many :ride_memberships
  has_many :users, through: :ride_memberships
end
