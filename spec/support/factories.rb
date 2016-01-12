FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    first_name 'John'
    last_name 'Smith'
    password 'password'
    password_confirmation 'password'
  end

  # Right justification is for padding book titles with zero's
  # Otherwise the SQL query retrieving these books and ordering by title
  # Will not order the books correctly for testing pagination.
  factory :book do
    sequence(:title) do |i|
      i = i.to_s.rjust(2, "0") if i < 10
      "Book Title#{i}"
    end
    sequence(:description) { |i| "A book about things#{i}" }
    year '1998'
    user
    genre
    author
  end

  factory :genre do
    genre_name 'Comedy'
  end

  factory :author do
    name 'Jane Doe'
  end

  factory :review do
    sequence(:title) { |i| "Awesome#{i}" }
    body 'Loved every minute'
    rating "5"
    book
    user
  end
end
