class User < ApplicationRecord

  has_many :followings, foreign_key: "follower_id", class_name: "Follow", dependent: :destroy
  has_many :followees, through: :followings, source: :followee
  has_many :reverse_followings, foreign_key: "followee_id", class_name: "Follow", dependent: :destroy
  has_many :followers, through: :reverse_followings, source: :follower


  validates_presence_of :name

  def follow(user)
    followees << user
  end

  def unfollow(user)
    followees.delete(user)
  end

  def followed_by(user)
    followers << user
  end

  def unfollowed_by(user)
    followers.delete(user)
  end

  def followers_count
    followers.count
  end

  def unfollowers_count
    User.where.not(id: followers.ids << id).count
  end

end
