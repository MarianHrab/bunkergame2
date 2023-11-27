class AddGameStartedToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :game_started, :boolean, default: false
  end
end
