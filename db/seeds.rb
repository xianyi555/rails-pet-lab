# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# Destroy everything to rebuild
Pet.destroy_all
Owner.destroy_all

# Owners
owners_data = []
4.times do
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

# Generate a random date between
# min_days_from_now days from now and
# max_days_from_now days from now.
# Both arguments can be negative, but
# min_days_from_now must be less than
# or equal to max_days_from_now.
def random_date(min_days_from_now, max_days_from_now)
  rng = Random.new
  (DateTime.now + rng.rand(min_days_from_now..max_days_from_now)).to_date
end

# Pets
# def random_pet_breed
#   ["dog", "cat", "reptile", "rabbit", "rodent", "rock", "amphibian", "giant robot", "fish"].sample
# end

# pets_data = []
# 6.times do
#   pets_data << {
#     name: FFaker::Name.first_name,
#     breed: random_pet_breed,
#     # date_of_birth: random_date(-2000.0, -3.0) #between 2000 and 3 days ago
#     owner: owners.sample
#   }
# end
# pets = Pet.create(pets_data)

