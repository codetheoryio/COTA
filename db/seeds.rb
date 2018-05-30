# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Create Admin User
admin = User.create!({first_name: "admin", email: "sreekanth@clearstack.io", :password => "cotarocks", :password_confirmation => "cotarocks" })
admin.add_role(:admin)