class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  #1人のユーザーが、同じ投稿に対して『いいね』を1回しかできないようにする
  validates :user_id, uniqueness: { scope: :post_id} 
end

