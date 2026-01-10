class CommentsController < ApplicationController
  before_action :authenticate_user! #ログインしないとコメントできない

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if@comment.save #これでコメントがDBに保存される
      redirect_to @post, notice:"コメントを投稿しました"
    else
      redirect_to @post, alert:"コメントを入力してください"
    end
  end

    def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @post, notice: "コメントを削除しました"
    else
      redirect_to @post, alert: "削除できません"
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
