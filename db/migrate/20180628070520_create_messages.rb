class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :send_from
      t.integer :send_to
      t.text :content

      t.timestamps
    end
  end
end
