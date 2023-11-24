class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true

      # Додайте інші стовпці за необхідності

      t.timestamps

    end
  end
end
