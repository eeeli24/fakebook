class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to :back
    else
      flash[:error] = 'Failed to save comment'
      redirect_to :back
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :post_id)
  end
end
