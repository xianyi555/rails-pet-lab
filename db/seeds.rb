# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Pet.destroy_all
Owner.destroy_all

Pet.create([
  { name: "Morocco", breed: "dog" },
  { name: "Kaylee", breed: "dog"}
])

Owner.create( first_name: "Brianna", last_name: "Veenstra", email:"b@v.com", phone:"4159876543")

Owner.find_by(first_name: "Brianna").pets << Pet.find_by(name: "Morocco")
Owner.find_by(first_name: "Brianna").pets << Pet.find_by(name: "Kaylee")
