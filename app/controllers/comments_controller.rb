class CommentsController < ApplicationController
  before_action :ensure_correct_user, only: %i[destroy]

  def create
    comment = current_user.comments.new(comment_params)
    #binding.pry
    if comment.save
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.board
    else
      flash[:alert] = "コメントを投稿できませんでした。"
      redirect_back fallback_location: comment.board
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to comment.board
  end

  protected

  def comment_params
    params.require(:comment).permit(:comment, :board_id, :user_id)
  end

  def ensure_correct_user
    comment = Comment.find(params[:id])
    if comment.user_id != current_user.id
      flash[:alert] = "投稿者しか削除できません"
      redirect_back fallback_location: comment.board
    end
  end
  
end
