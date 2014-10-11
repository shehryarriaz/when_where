# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.delete_all

User.create(name: "Shehryar Riaz", role: "admin", email: "shehryar@ga.com", password: "password", password_confirmation: "password")
User.create(name: "Stefanie Lim", role: "admin", email: "stef@ga.com", password: "password", password_confirmation: "password")
User.create(name: "Kate Montgomery", role: "basic_user", email: "kate@ga.com", password: "password", password_confirmation: "password")
User.create(name: "Laurence James", role: "basic_user", email: "laurence@ga.com", password: "password", password_confirmation: "password")
User.create(name: "Francesco Papini", role: "basic_user", email: "francesco@ga.com", password: "password", password_confirmation: "password")
