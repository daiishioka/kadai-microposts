class Micropost < ApplicationRecord
  belongs_to :user #User と Micropost の一対多を表現
  
  has_many :favorites, dependent: :destroy
  has_many :users, through: :likes
  
  validates :content, presence: true, length: { maximum: 255 }
end

