class User < ApplicationRecord
	before_save { self.email.downcase! }	#文字を全て小文字にする
	validates :name, presence: true, length: { maximum: 50 }		#空を許さず50文字以内
	validates :email, presence: true, length: {maximum: 255 },
										format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },		#emailの正規表現
										uniqueness: { case_sensitive: false }		#重複を許さず大文字と小文字を区別しない
	has_secure_password #モデルファイル作成
	
	has_many :microposts #User から Micropost をみたとき、複数存在するので
	
	#Userからみた中間テーブルとの関係
	has_many :relationships	#自分がフォローしているUserへの参照
	has_many :followings, through: :relationships, source: :follow	#「フォローしているUser達」を表現し、「中間テーブルを指定」し、「どれを参照先のidとすべきか」を選択
	has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'	#自分をフォローしているUserへの参照
	has_many :followers, through: :reverses_of_relationship, source: :user
	
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
  	Micropost.where(user_id: self.following_ids + [self.id])
  end
end