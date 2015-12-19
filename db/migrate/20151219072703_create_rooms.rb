class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :male
      t.integer :female

      t.timestamps null: false
    end
  end
end
