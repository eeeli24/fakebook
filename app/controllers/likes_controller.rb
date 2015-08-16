class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: post)
    if @like.save
      redirect_to :back
    else
      flash[:error] = 'Failed to like the post'
      redirect_to :back
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to :back
  end
end
