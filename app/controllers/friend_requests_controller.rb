class FriendRequestsController < ApplicationController
  def create
    FriendRequest.create(from_id: params[:from_id], to_id: params[:to_id])
    redirect_to User.find_by(id: params[:to_id])
  end

end
