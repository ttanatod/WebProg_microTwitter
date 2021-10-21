class Post < ApplicationRecord
  belongs_to :user
  validates :msg, presence: true

  has_many :likes, dependent: :destroy
  has_many :liker, through: :likes

  def is_like_by(user)
    return liker.include?(user)
  end
end
