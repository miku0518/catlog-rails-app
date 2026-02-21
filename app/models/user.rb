class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post #ユーザーがいいねをおした掲示板を中間テーブルを通して集める
  has_one :profile, dependent: :destroy #1対１だから
  has_many :comments, dependent: :destroy

  before_destroy :check_guest_user
  before_update :check_guest_user

  #ゲストログイン
  def self.guest #User全体の中から
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.login_name = 'ゲストユーザー'
    end
  end

  def check_guest_user
    # ゲストユーザーのメールアドレスだった場合、処理を中断する
    if email == 'guest@example.com'
      errors.add(:base, "ゲストユーザーは編集・削除できません。")
      throw :abort # これでデータベースへの保存や削除を強制的に中止します
    end
  end
end
