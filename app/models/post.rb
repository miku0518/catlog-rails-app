class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.search(search_word) #LIKEはSQLでは～を含むと言う意味
    Post.where(["title LIKE ? OR body LIKE ?", "%#{search_word}%", "%#{search_word}%"])
  end
end
