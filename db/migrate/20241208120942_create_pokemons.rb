class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :image_url
      t.string :type
      t.string :main_power
      t.integer :level
      t.integer :age
      t.integer :sexe
      t.boolean :rented
      t.integer :price_per_day
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
