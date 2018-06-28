class TokenUnique < ActiveRecord::Migration[5.2]
  def change
      add_index :tokens, :content, unique:true
  end
end
