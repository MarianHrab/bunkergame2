class AddCharacteristicToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :characteristic, foreign_key: true
  end
end
