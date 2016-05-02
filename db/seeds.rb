# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pet.destroy_all
Owner.destroy_all

owners_data = []
8.times do
  first = FFaker::Name.first_name
  last = FFaker::Name.last_name
  owners_data << {
    first_name: first,
    last_name: last,
    email: "#{first[0]}_#{last}@example.com".downcase,
    phone: FFaker::PhoneNumber.phone_number
  }
end

owners = Owner.create(owners_data)


def random_pet_breed
  ["dog", "cat", "reptile", "rabbit", "rodent", "rock", "amphibian", "giant robot", "fish"].sample
end

def random_recent_date(min_days_ago, max_days_ago)
  rng = Random.new
  (DateTime.now - rng.rand(min_days_ago..max_days_ago)).to_date
end


pets_data = []
12.times do
  pets_data << {
    name: FFaker::Name.first_name,
    breed: random_pet_breed,
    date_of_birth: random_recent_date(3.0, 2000.0)
  }
end

pets_data.each do |pet_data|
  pet = Pet.create(pet_data)
  owners.sample.pets << pet
end
