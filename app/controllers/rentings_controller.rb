class RentingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pokemon, only: [:index, :show, :new, :create, :edit]
  before_action :set_renting, only: [:show, :edit]

  def index
    #@rentings = @Pokemon.rentings
    @rentings = current_user.rentings
  end

  def show
    @renting = @pokemon.rentings.find(params[:id])
  end

  def new
    @renting = Renting.new
  end

  def create
    # selected_dates = params[:renting][:start_date] #.split(" to ")
    # start_date = selecrrted_dates[0]
    # end_date = selected_dates[1]
    @renting = Renting.new(renting_params)
    @renting.pokemon = @pokemon
    @renting.user = current_user
    if @renting.save!
      redirect_to pokemon_path(@pokemon)
    else
      redirect_to pokemon_path(@pokemon)
    end

  end

  def edit
    @renting = @pokemon.rentings.find(params[:id])
  end

  private

  def renting_params
    params.require(:renting).permit(:start_date, :end_date)
  end

  def set_renting
    @renting = Renting.find(params[:id])
  end

  def set_pokemon
    @pokemon = Pokemon.find(params[:pokemon_id])
  end
end
