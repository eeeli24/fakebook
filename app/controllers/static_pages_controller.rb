class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @post = Post.new
    @comment = Comment.new
    @posts = current_user.timeline.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def about
  end
end
