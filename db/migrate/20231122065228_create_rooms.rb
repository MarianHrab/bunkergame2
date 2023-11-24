class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.references :owner, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
