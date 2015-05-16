class FriendRequestsController < ApplicationController
  def create
    FriendRequest.create(from_id: params[:from_id], to_id: params[:to_id])
    redirect_to User.find_by(id: params[:to_id])
  end

  def update
    if params[:friend_request][:choice] == 'accept'
      User.find_by(id: params[:to_id]).make_friends(User.find_by(id: params[:from_id]))
    end
    FriendRequest.where('from_id = (?) AND to_id = (?)', params[:from_id], params[:to_id])[0].destroy
    flash[:success] = 'You have a new friend now!'
    redirect_to root_url
  end

end
