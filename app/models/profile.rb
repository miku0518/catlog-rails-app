class Profile < ApplicationRecord
  belongs_to :user
  validates :profile_name, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 200 }, allow_blank: true
  validates :cat_count, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  before_update :check_guest_profile
  has_one_attached :avatar

  def avatar_or_default
    if avatar.attached?
      avatar
    else
      "default_cat_blue.png"  # app/assets/images にあるファイル名
    end
  end

  def check_guest_profile
    # 紐付いているユーザーのメールアドレスがゲストのものか判定
    if user.email == 'guest@example.com'
      errors.add(:base, "ゲストユーザーのプロフィールは編集できません。")
      throw :abort # 保存処理を強制的に中断する
    end
  end
end
