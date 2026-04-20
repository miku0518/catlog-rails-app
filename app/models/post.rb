class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image # 1つのデータ（例えば1つの投稿）に対して、1つの画像を紐づける
  has_many :comments, dependent: :destroy #連動して削除
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user #投稿にいいねしたユーザー達を中間テーブルを抜けてユーザーテーブル探してね

  def liked_by?(user)
    likes.exists?(user_id: user.id) #いいね名簿」の中に「その人のID」があるか探す！
  end
end
