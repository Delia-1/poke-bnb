class RenameTypeToMainTypeInPokemons < ActiveRecord::Migration[7.1]
  def change
    rename_column :pokemons, :type, :main_type
  end
end
