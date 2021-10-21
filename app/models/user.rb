class User < ApplicationRecord
	validates :name, :email, presence: true, uniqueness: true
	validates :password, presence: true, length: {minimum: 4}
	
	#follow relation
	has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
    has_many :followees, through: :followed_users
    has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
    has_many :followers, through: :following_users

	has_many :posts
	has_secure_password

	#like relation
	has_many :likes, dependent: :destroy
	has_many :liked, through: :likes

	def get_feed_post
		post = Array.new
		ids = Follow.where(follower_id: id).pluck('followee_id')
		return Post.where(user_id: ids).order('created_at DESC')
	end
end
