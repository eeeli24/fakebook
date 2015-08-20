class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :recoverable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

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

  validates :name, presence: true

  self.per_page = 10

  def self.from_omniauth(auth)
    where(auth.slice(provider: auth.provider, uid: auth.uid)).first_or_create do |user|
      user.email    = auth.info.email
      pass = Devise.friendly_token[0,20]
      user.password = pass
      user.passwod_confirmation = pass
      user.name     = auth.info.name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

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
