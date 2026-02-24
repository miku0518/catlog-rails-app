class LikesController < ApplicationController
  #どっちのアクションにも
  before_action :set_post #set_postの内容をしてほしい時は、onlyはかかない

  def create
    #現在ログインしているユーザーが、その投稿にいいねをしているのか見つけて、ない場合は作る
    #作る必要がある理由: データを保存しないと、いいねが記録されないから。
    #探す必要がある理由: 二重にいいねが作られるのを防ぐため。
    @post.likes.find_or_create_by(user:current_user )
    # locals: { post: @post } の左側の名前が、この部品の中での変数名になる
    render partial: "likes/like_button", locals: { post: @post }
  end

  def destroy
    @post.likes.find_by(user: current_user)&.destroy
    render partial: "likes/like_button", locals: { post: @post }
  end

  private

  def set_post
    # Postモデルを使って、データベースから特定の投稿データを1件取ってくる
    #ユーザーがいいねを押した投稿のパラメータ{(params[:post_id])にはIDしかはいらない}をもとに検索する
    @post = Post.find(params[:post_id])
  end
end
