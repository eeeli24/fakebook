class FriendRequestsController < ApplicationController

  def index
    @incoming = current_user.incoming_requests
    @outgoing = current_user.friend_requests
  end

  def create
    friend = User.find(params[:friend_id])
    @friend_request = current_user.friend_requests.new(friend: friend)
    if @friend_request.save
      flash[:success] = 'Request sent.'
      redirect_to root_path
    else
      flash.now[:error] = 'Request failed.'
      render :back
    end
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.accept
    flash[:success] = 'Added to friends.'
    redirect_to root_path
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    flash[:success] = 'Request canceled.'
    redirect_to root_path
  end
end
