class Post < ApplicationRecord
  belongs_to :user
  validates :msg, presence: true

  has_many :likes, dependent: :destroy
  has_many :liker, through: :likes

  def is_like_by(user)
    return liker.include?(user)
  end

  def get_likers_name
    # User.where(id: self.likes.pluck('user_id')).pluck('name').join(" ")
    # return self.likes.joins(:liker).pluck('name').join(" ")
    return self.liker.pluck('name').join(" ")
  end
end
