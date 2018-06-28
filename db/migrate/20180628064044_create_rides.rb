class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.string :title
      t.string :time_start
      t.string :time_end
      t.string :description
      t.string :from
      t.string :to
      t.integer :vehicle
      t.string :num_passenger_max

      t.timestamps
    end
  end
end
