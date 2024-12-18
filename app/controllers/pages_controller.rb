class PagesController < ApplicationController
  def home
  end

  def memory
    @pokemons = Pokemon.limit(12)
    @cards = (@pokemons + @pokemons).shuffle
  end
end
