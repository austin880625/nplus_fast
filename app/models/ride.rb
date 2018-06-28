class Ride < ApplicationRecord
  validates_presence_of :title, :time_start, :time_end, :from, :to, :vehicle
  has_many :users
end
