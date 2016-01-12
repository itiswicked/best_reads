class Review < ActiveRecord::Base
  include PgSearch
  multisearchable against: :title

  belongs_to :book
  belongs_to :user

  validates :body, length: { maximum: 500 }
  validates :rating, presence: true

  paginates_per 20

  def full_user_name
    "#{user.first_name.capitalize} #{user.last_name.chars.first.capitalize}"
  end
end
