class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :my_id, null: false
      t.integer :vote_id, null: false
      t.string :room_id

      t.timestamps null: false
    end
  end
end
