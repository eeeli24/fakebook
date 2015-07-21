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

  has_attached_file :avatar,
  styles: { profile: '250x250', post: '50x50', small: '25x25' },
  default_url: ':style/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

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

  # Get a full name for a country from country_code stored in database
  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
end
