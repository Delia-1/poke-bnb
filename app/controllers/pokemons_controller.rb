class PokemonsController < ApplicationController
  def index
    if params[:query].present?
      @pokemons = Pokemon.search_by_name_and_main_type_and_main_power(params[:query])
    else
      @pokemons = Pokemon.all
    end
    @pokemon = Pokemon.new
  end

  def show
    @pokemon = Pokemon.find(params[:id])
    @renting = Renting.new
    # @rentings = @pokemon.rentings.include(:user)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

   private

  def pokemon_params
    params.require(:pokemon).permit(:name)
  end
end
