class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests, source: :friend
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments

  def incoming_requests
    FriendRequest.where(friend_id: id)
  end

  def remove_friend(friend)
    current_user.friends.destroy(friend)
  end

  # A feed of self + friends posts
  def timeline
    friend_ids = 'SELECT friend_id FROM friendships
                  WHERE  user_id = :user_id'
    Post.where("user_id IN (#{friend_ids})
                OR user_id = :user_id", user_id: id).order(created_at: :desc)
  end
end
