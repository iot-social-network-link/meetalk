class ChangeColumnMatches < ActiveRecord::Migration
  def change
    rename_column :matches, :my_id, :user_id
  end
end
