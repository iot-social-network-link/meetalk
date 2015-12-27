class AddWindowidToUser < ActiveRecord::Migration
  def change
    add_column :users, :window_id, :string
  end
end
