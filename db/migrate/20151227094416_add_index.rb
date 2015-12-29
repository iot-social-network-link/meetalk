class AddIndex < ActiveRecord::Migration
  def change
    add_index :users, :room_id
    add_index :matches, :room_id
  end
end
