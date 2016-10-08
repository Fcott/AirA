class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :rooms, :is_kittchen, :is_kitchen
  end
end
