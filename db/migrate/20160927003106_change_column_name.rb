class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :rooms, :accomodate, :accommodate
  end
end
