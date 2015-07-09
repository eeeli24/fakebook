class FriendRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :not_friends_already
  validate :not_pending_already

  def accept
    user.friends << friend
    friend.friends << user
    destroy
  end

  private

  def not_friends_already
    errors.add(:friend, 'is already added') if user.friends.include?(friend)
  end

  def not_pending_already
    errors.add(:friend, 'already sent a request') if friend.pending_requests.include?(user)
  end
end
