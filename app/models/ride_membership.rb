class RideMembership < ApplicationRecord
  belongs_to :ride
  belongs_to :user
end
