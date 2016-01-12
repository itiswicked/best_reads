FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'
    password_confirmation 'password'
  end

  factory :book do
    title 'Book Name'
    description 'A book about things'
    year '1988'
    genre
    author
    user
  end

  factory :genre do
    genre_name 'Comedy'
  end

  factory :author do
    name 'Jane Doe'
  end

  factory :review do
    sequence(:title) { |i| "Review Title#{i}!" }
    body "Review Body"
    rating 4
    book
    user
  end
end
