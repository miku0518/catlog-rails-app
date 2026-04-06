class Profile < ApplicationRecord
  #1対1
  belongs_to :user
  #画像１枚
  has_one_attached :avatar

  #プロフィールの名前が空白はだめで、２０文字以内か保存する前にチェック
  validates :profile_name, presence: true, length: { maximum: 20 }
  #未入力（任意項目）でいいけれど、もし入力するなら200文字以内
  validates :introduction, length: { maximum: 200 }, allow_blank: true
  #ねこの数が、数値型であること、０以上で整数であること
  validates :cat_count, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  #ユーザが更新する前に実行する処理
  before_update :check_guest_profile

  def avatar_or_default
    if avatar.attached? #アバター画像、持ってるか
      avatar
    else
      "default_cat_blue.png"  # app/assets/images にあるファイル名
    end
  end

  private

  def check_guest_profile
    # 紐付いているユーザーのメールアドレスがゲストのものか判定
    if user.email == 'guest@example.com'
      errors.add(:base, "ゲストユーザーのプロフィールは編集できません。")
      throw :abort # 保存処理を強制的に中断する
    end
  end
end
