# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


mateo = User.create(email: 'mateo@example.com',
                   password: 'mateo123',
                   password_confirmation: 'mateo123',
                   username: 'Mateo',
                   role: User.roles[:admin])

User.create(email: 'cata@example.com',
            password: 'cata123',
            password_confirmation: 'cata123',
            username: 'Cata')
User.create(email: 'vero@example.com',
            password: 'vero123',
            password_confirmation: 'vero123',
            username: 'Vero')

mateo.joined_rooms << Room.create(name: 'General', is_private: false)
mateo.joined_rooms << Room.create(name: 'Testing', is_private: false)
