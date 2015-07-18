class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :likers, through: :likes, source: :user
  has_many :comments

  validates :body, presence: true

  self.per_page = 10
end
