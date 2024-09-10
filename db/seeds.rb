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

DESCRIPTION_PETS = {
  cat: {
    description: "I'm a cat. I’m independent but enjoy your company when I feel like it. I love exploring, napping in the sun, and being pampered – but only when I say so. Purr when I’m happy!",
    likes: "I enjoy sunbathing, hunting toys, and quiet, cozy corners. Oh, and head scratches.",
    dislikes: "I dislike being bothered when I’m not in the mood, loud people, and getting wet."
  },
  dog: {
    description: "I'm a dog, and I'm your loyal best friend. I love playing, going for walks, and learning new tricks. I'm always by your side, ready for cuddles or to protect you. Let’s have some fun!",
    likes: "I love running, playing fetch, belly rubs, and being with my human!",
    dislikes: "I don't like being alone for too long, loud noises, or not getting enough attention."
  },
  rabbit: {
    description: "I’m a rabbit! I love hopping around, munching on veggies, and finding cozy spots to hide. I’m curious but a little shy, so I like to feel safe. Oh, and I’m super soft!",
    likes: "I love munching on fresh veggies, hopping around, and digging little burrows.",
    dislikes: "I don’t like loud noises, being picked up too quickly, or being left in an open space without hiding spots."
  },
  birds: {
    description: "Tweet tweet! We are birds, and we love to fly and sing. Some of us have beautiful feathers, and others, sweet voices. We enjoy the freedom of the sky, but we can be great companions too!",
    likes: "We enjoy flying, singing, and having a high perch to watch the world!",
    dislikes: "We don’t like small, cramped cages, sudden movements, or being ignored."
  },
  reptiles: {
    description: "I'm a reptile. I might not be fluffy, but I'm fascinating! I love basking in the sun, staying calm, and enjoying peaceful environments. Whether I’m a snake, lizard, or turtle, I’m a chill companion.",
    likes: "I enjoy basking in the sun, having a warm habitat, and staying calm and relaxed.",
    dislikes: "I don’t like cold environments, being handled too much, or loud, stressful spaces."
  }
}

DESCRIPTION_SERVICES = [
  {
    description: "Take care of cats. Administer Injections, Administer Medicine, Special Care, Experience with elderly pets",
    restrictions: "Only care for sterilized females. Extra restriction: Preferably not aggressive",
    house_description: "Lives in: House, 24 hour supervision: Yes, Do they smoke inside the house: No, Children present: No, Pets at home: Dogs, Free space: Front garden, Garage, Patio/terrace"
  },
  {
    description: "Take care of dogs. Administer Injections, Administer Medicine, Special Care, Experience with elderly pets",
    restrictions: "Does not accept females in heat, Does not accept puppies",
    house_description: "Lives in: House, 24 hour supervision: Yes, Do they smoke inside the house: No, Children present: No, Free space: Balcony, Patio/terrace"
  },
  {
    description: "Take care of dogs. Administer Medicine, Special Care",
    restrictions: "Only care for sterilized females, Only care for sterilized males, Only accept 1 client at a time, Extra restriction: Live with other dogs. Not aggressive.",
    house_description: "Lives in: House, 24 hour supervision: No, Do they smoke inside the house: No, Children present: No, Pets at home: Dogs, Free space: Garage, Patio/terrace"
  }
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

users = User.all

if users.count.zero?
  puts "Creating users..."
  create_user
  puts "Users: #{User.all.count}"
end

USERS = User.all

def set_description_pet(animal, name)
  "Hi, #{name} #{DESCRIPTION_PETS[animal.to_sym][:description]}"
end

def base_pet(animal, name_pet)
  initial_pet = {
    name: name_pet, specie: animal,
    description: set_description_pet(animal, name_pet),
    likes: DESCRIPTION_PETS[animal.to_sym][:likes],
    dislikes: DESCRIPTION_PETS[animal.to_sym][:dislikes],
    age: Faker::Number.within(range: 1..15),
    weight: Faker::Number.within(range: 1..10),
    user_id: USERS.flat_map { |u| u[:id] }.sample
  }
  return Pet.new(initial_pet)
end

puts "Creating pets..."
2.times do
  %w[dog cat rabbit birds reptiles].each do |animal|
    name_pet = animal == "dog" ? Faker::Creature::Dog.name : Faker::Creature::Cat.name
    pet = base_pet(animal, name_pet)
    pet.save
  end
end
puts "Pets: #{Pet.all.count}"

def base_service(user, random)
  return {
    price: Faker::Number.within(range: 60..320),
    description: random[:description],
    address: Faker::Address.full_address,
    latitude: user["location"]["coordinates"]["latitude"],
    longitude: user["location"]["coordinates"]["longitude"],
    restrictions: random[:restrictions],
    house_description: random[:house_description],
    user_id: USERS.flat_map { |u| u[:id] }.sample
  }
end

def create_service
  url = "https://randomuser.me/api/?page=1&results=4&seed=abc"
  users = JSON.parse(URI.open(url).read)["results"]
  users.each do |user|
    random_details = DESCRIPTION_SERVICES.sample
    Service.create(base_service(user, random_details))
  end
end

services = Service.all.count
if services.zero?
  puts "Creating services..."
  create_service
  puts "Services: #{Service.all.count}"
end
