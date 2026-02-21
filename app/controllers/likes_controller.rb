class LikesController < ApplicationController
  before_action :set_post

  def create
    # すでにいいねしていなければ作る
    @post.likes.find_or_create_by(user: current_user)
    redirect_to @post
  end

  def destroy
    # いいねを削除
    like = @post.likes.find_by(user: current_user)
    like&.destroy
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
