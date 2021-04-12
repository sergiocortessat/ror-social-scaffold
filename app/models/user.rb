class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    inverse_friendship = inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array += inverse_friendship
    friends_array.compact
  end

  # Users who have yet to confirme friend requests

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def friend?(user)
    friends.include?(user)
  end

  def friends_and_own_posts
    myfriends = friends
    our_posts = []
    myfriends.each do |f|
      f.posts.each do |p|
        our_posts << p
      end
    end
    posts.each do |p|
      our_posts << p
    end
    our_posts.uniq
  end
end
