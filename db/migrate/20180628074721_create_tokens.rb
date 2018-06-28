class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end
end
