class AddStatusColumn < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer, :default => 1
    add_column :rooms, :status, :integer, :default => 1
  end
end
