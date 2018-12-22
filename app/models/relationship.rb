class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' #followがFollowという存在しないクラスを参照することを防ぎ、Userクラスを参照するものだと明示する。
end
