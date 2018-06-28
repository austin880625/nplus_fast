class AddCreatedBy < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :created_by, :integer  
  end
end
