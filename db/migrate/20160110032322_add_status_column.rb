class AddStatusColumn < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer
    add_column :rooms, :status, :integer
  end
end
