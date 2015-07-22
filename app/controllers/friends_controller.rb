class FriendsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @friends = @user.friends
  end

  def destroy
    @friend = current_user.friends.find(params[:id])
    current_user.friends.destroy(@friend)
    flash[:success] = "Removed #{@friend.name} from friends."
    redirect_to :back
  end
end
