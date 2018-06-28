class AddDriverPassengersToRide < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :driver, :integer
    add_column :rides, :passengers, :integer, array: true, default: []
  end
end
