# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"
require 'faker'

DESCRIPTION_USERS = [
  "Person, a cat lover. Person is a devoted cat owner who has two adorable rescue cats, Luna and Whiskers. she enjoys spending time playing with them and loves to spoil them with new toys. Person often shares cute moments of her cats on social media and participates in local animal rescue events. Her cat are like family to her, and she makes sure they live a happy and healthy life.",
  "Person, a dog enthusiast. Person is the proud owner of a Golden Retriever named Max. she enjoys going on long hikes and outdoor adventures with Max, making sure to keep his dog active and entertained. Person is also part of a local dog training group, where he helps others teach their pets new tricks. Max is more than just a pet to Person she's his loyal companion and best friend.",
  "Person, the small animal caretaker. Person has a soft spot for small animals. she takes care of two guinea pigs, Charlie and Peanut, and loves creating fun habitats for them. Person is constantly learning about how to improve their well-being and nutrition, and she enjoys educating others about the joy of having small pets. Her guinea pigs are her little furry companions who keep her company at home.",
  "Person, the exotic pet owner. Person has always been fascinated by exotic pets. she owns a colorful parrot named Rio and a bearded dragon named Spike. she spends his time ensuring their environments are as close to their natural habitats as possible. Person is known for his knowledge of reptiles and birds, and he's always eager to share tips with fellow exotic pet enthusiasts."
]

def clean_database
  User.destroy_all
end

puts "Cleaning up database..."
clean_database
puts "Database cleaned"

def set_description(description, user)
  gender = user["name"]["gender"] == "male" ? "He" : "She"
  description.gsub('Person', user["name"]["first"])
  description.gsub('she', gender)
end

def base_user(user)
  initial_user = {
    email: user["email"],
    password: "password",
    first_name: user["name"]["first"],
    last_name: user["name"]["last"] || "Flores",
    address: Faker::Address.full_address,
    phone_number: user["cell"] || Faker::PhoneNumber.phone_number_with_country_code,
    description: set_description(DESCRIPTION_USERS.sample, user)
  }
  return User.new(initial_user)
end

def create_user
  url = "https://randomuser.me/api/?page=1&results=4&seed=abc"
  users = JSON.parse(URI.open(url).read)["results"]
  users.each do |user|
    # file_name = user["id"]["value"] || user["name"]["first"]
    # file = URI.parse(user["picture"]["large"]).open
    user_content = base_user(user)
    # user_content.photo.attach(io: file, filename: file_name, content_type: "image/png")
    user_content.save
  end
end

users_count = User.all.count

if users_count.zero?
  puts "Creating users..."
  create_user
  puts "Users: #{User.all.count}"
end
