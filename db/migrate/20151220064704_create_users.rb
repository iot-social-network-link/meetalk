class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :room_id

      t.timestamps null: false
    end
  end
end
