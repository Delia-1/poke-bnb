class CreateRentings < ActiveRecord::Migration[7.1]
  def change
    create_table :rentings do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :pokemon, null: false, foreign_key: true

      t.timestamps
    end
  end
end
