class ChangeColumnsRoom < ActiveRecord::Migration
  def change
    change_column_default :rooms, :male, 0
    change_column_default :rooms, :female, 0
  end
end
