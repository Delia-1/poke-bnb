# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

POKEAPI_BASE_URL = "https://pokeapi.co/api/v2/pokemon?limit=100&offset=0"
puts "destroying all"
Pokemon.destroy_all
User.destroy_all

puts "db cleaned, now fetching data"

# Create users
user1 = User.create!(email: "test1@test.com", password: "123456", username: "Sacha", first_name:"Sacha", last_name:"besti",)
user2 = User.create!(email: "test2@test.com", password: "123456", username: "Odine", first_name:"Odine", last_name:"deleau",)
user3 = User.create!(email: "test3@test.com", password: "123456", username: "Booby", first_name:"Booby", last_name:"Reale",)
user4 = User.create!(email: "test4@test.com", password: "123456", username: "Délia", first_name:"Délia", last_name:"Knoep",)


encoded_url = URI.encode(url)
  # Step 1: Fetch the list of Pokémon
  encoded_url = URI.encode(POKEAPI_BASE_URL)
  URI.parse(encoded_url)
  list_response = URI.open(POKEAPI_BASE_URL).read
  list_data = JSON.parse(list_response)

  # Step 2: Loop through each Pokémon URL and fetch its details
  list_data["results"].each_with_index do |pokemon, index|
    pokemon_url = pokemon["url"] # URL for individual Pokémon details

    # Fetch details for the individual Pokémon
    details_response = URI.open(pokemon_url).read
    details_data = JSON.parse(details_response)

    # Create the Pokémon record
    Pokemon.create!(
      name: details_data["name"],
      image_url: details_data["sprites"]["front_default"],
      main_power: details_data["abilities"][0]["ability"]["name"].capitalize, # First ability
      level: rand(1..100), # Random level
      age: rand(1..20), # Random age
      sexe: [0, 1].sample, # Random gender (0: Female, 1: Male)
      rented: false,
      price_per_day: rand(10..50),
      user: [user1, user2, user3, user4].sample, # Set to nil for now
    )

    puts "Created Pokémon: #{details_data["name"].capitalize}"
  end

  puts "Seeding completed successfully!"
