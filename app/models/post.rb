class Post < ApplicationRecord
  belongs_to :user
  validates :msg, presence: true
end
