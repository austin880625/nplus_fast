class MaxPassengersStringToInt < ActiveRecord::Migration[5.2]
  def change
    change_column :rides, :num_passenger_max, :integer
  end
end
