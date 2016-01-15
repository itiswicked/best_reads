require_relative '../spec/support/factories'

Genre.create(genre_name: "Comedy")
Genre.create(genre_name: "Drama")
Genre.create(genre_name: "Non-Fiction")
Genre.create(genre_name: "Realistic Fiction")
Genre.create(genre_name: "Romance Novel")
Genre.create(genre_name: "Satire")
Genre.create(genre_name: "Tragedy")
Genre.create(genre_name: "TragiComedy")

User.create(first_name: "J", last_name: "G", email: "jujukoo@gmail.com",
            password: "password", password_confirmation: "password",
            role: "admin")
