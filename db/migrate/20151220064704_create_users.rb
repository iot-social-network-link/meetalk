class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :gender, null: false
      t.integer :room_id, null: false
      t.string :window_id

      t.timestamps null: false
    end
  end
end
