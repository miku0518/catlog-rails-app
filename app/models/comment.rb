class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  #コメントがあるかチェックする
  validates :body, presence: true
end
