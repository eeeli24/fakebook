class PostsController < ApplicationController

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path
    else
      render home_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
