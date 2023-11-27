class CreateCharacteristics < ActiveRecord::Migration[7.1]
  def change
    create_table :characteristics do |t|
      t.integer :age
      t.integer :height
      t.integer :weight
      t.string :health
      t.string :phobia
      t.string :hobby
      t.string :character
      t.string :luggage
      t.text :additional_info
      t.string :knowledge
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
