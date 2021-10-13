class Follow < ApplicationRecord
  # belongs_to :follower, foreign_key: "follower_id", class_name: "User"
  # belongs_to :followee, foreign_key: "followee_id", class_name: "User"
  
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates :follower, presence: true
  validates :followee, presence: true
end
