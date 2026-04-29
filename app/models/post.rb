class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def self.search(search_word)
    Post.where(["title LIKE ? OR body LIKE ?", "%#{search_word}%", "%#{search_word}%"])
  end
end
