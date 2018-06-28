class CreateRideMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :ride_memberships do |t|
      t.integer :user_id
      t.integer :ride_id

      t.timestamps
    end
  end
end
