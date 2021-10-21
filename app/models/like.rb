class Like < ApplicationRecord
  belongs_to :liked, class_name: 'Post', foreign_key: 'post_id'
  belongs_to :liker, class_name: 'User', foreign_key: 'user_id'
end
