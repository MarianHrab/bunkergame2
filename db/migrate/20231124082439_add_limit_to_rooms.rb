class AddLimitToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :limit, :integer
  end
end
