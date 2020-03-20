# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

AdminUser.destroy_all
AdminUser.create!(email: 'admin@telecom.com', password: 'sxdx1718', password_confirmation: 'sxdx1718')
AdminUser.create!(email: 'support@telecom.com', password: 'support@123', password_confirmation: 'support@123')

