class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if@comment.save #これでコメントがDBに保存される
      redirect_to @post, notice: "コメントを投稿しました"
    else
      redirect_to @post, alert: "コメントの投稿に失敗しました"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to @post, notice: "コメントを削除しました", status: :see_other #処理が終わったから、指定したページを新しく読み込み直してねと合図
    else
      redirect_to @post, alert: "削除できません",status: :see_other
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
