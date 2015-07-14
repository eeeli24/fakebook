class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friend_requests, dependent: :destroy
  has_many :pending_requests, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts
  has_many :likes
  has_many :comments

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end
end
