class FriendRequestsController < ApplicationController
  def create
    FriendRequest.create(friend_request_params)
    redirect_to User.find_by(id: params[:friend_request][:to_id])
  end

  private
  def friend_request_params
    params.require(:friend_request).permit(:from_id, :to_id)
  end
end
