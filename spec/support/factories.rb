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
    genre_id '1'
    author_id '1'
  end

  factory :genre do
    genre_name 'Comedy'
  end

  factory :author do
    name 'Jane Doe'
  end

  factory :review do
    title "Review Title!"
    body "Review Body"
    rating 4
  end
end
