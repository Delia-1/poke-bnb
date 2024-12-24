class PagesController < ApplicationController
  def home
  end

  def memory
    @pokelist = Pokemon.all.sample(12) # Prendi tutti i Pokémon dal database e seleziona 12 casualmente
    @cards = (@pokelist + @pokelist).shuffle # Crea il mazzo e lo mescola
  end

end



# @pokemons = Pokemon.sample.limit(12)
