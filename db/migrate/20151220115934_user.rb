class User < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :nickname, :name
      t.change :room_id, :integer, null: false
      t.string :gender
    end
  end
end
