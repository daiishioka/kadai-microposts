class Micropost < ApplicationRecord
  belongs_to :user　#User と Micropost の一対多を表現
  
  validates :content, presence: true, length: { maximum: 255 }
end
