class Genre < ActiveRecord::Base
  include PgSearch
  multisearchable against: :genre_name

  has_many :books
  has_many :authors, through: :books
end
