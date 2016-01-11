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

  factory :dynamic_book, class: Book do
    sequence(:title) do |i|
      i = i.to_s.rjust(2, "0") if i < 10
      "Book Title#{i}"
    end
    sequence(:description) { |i| "A book about things#{i}" }
    year '1998'
    sequence(:user_id) { |i| "#{i}" }
    sequence(:genre_id) { |i| "#{i}" }
    sequence(:author_id) { |i| "#{i}" }
  end

  factory :genre do
    genre_name 'Comedy'
  end

  factory :author do
    name 'Jane Doe'
  end

  # must create association with book manually
  factory :review do
    sequence(:title) { |i| "Awesome#{i}" }
    body 'Loved every minute'
    rating "5"
    user_id "1"
  end
end
