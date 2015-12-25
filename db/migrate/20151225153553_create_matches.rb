class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :my_id
      t.integer :vote_id

      t.timestamps null: false
    end
  end
end
