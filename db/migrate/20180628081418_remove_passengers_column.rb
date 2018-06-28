class RemovePassengersColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides ,:passengers
  end
end
