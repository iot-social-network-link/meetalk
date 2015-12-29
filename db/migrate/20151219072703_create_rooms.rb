class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :male, null: false
      t.integer :female, null: false

      t.timestamps null: false
    end
  end
end
