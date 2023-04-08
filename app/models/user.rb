class User < ApplicationRecord

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'

  # List of users followed by the user
  has_many :followees, through: :followed_users, class_name: 'User'

  # List of users who follow the user or List of followers
  has_many :followers, through: :following_users, class_name: 'User'


  validates_presence_of :name
end
