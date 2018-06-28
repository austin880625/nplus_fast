class User < ApplicationRecord
  has_many :ride_memberships
  has_many :rides, through: :ride_memberships
  
end
