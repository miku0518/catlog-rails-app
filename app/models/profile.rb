class Profile < ApplicationRecord
  belongs_to :user
  validates :profile_name, presence: true, length: { maximum: 20 }
  validates :introduction, length: { maximum: 200 }, allow_blank: true
  validates :cat_count, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  has_one_attached :avatar

    def avatar_or_default
    if avatar.attached?
      avatar
    else
      "default_cat_blue.png"  # app/assets/images にあるファイル名
    end
  end
end
