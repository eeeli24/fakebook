class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @post = Post.new
  end

  def about
  end
end
