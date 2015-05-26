class FriendRequestsController < ApplicationController
  after_action :send_notification, only: [:create]
  after_action :delete_notification, only: [:update]
  def create
    FriendRequest.create(from_id: params[:from_id], to_id: params[:to_id]) unless User.find(params[:from_id]) == User.find(params[:to_id])
    redirect_to User.find_by(id: params[:to_id])
  end

  def update
    if params[:friend_request][:choice] == 'accept'
      User.find_by(id: params[:to_id]).make_friends(User.find_by(id: params[:from_id]))
      flash[:success] = 'You have a new friend now!'
    end
    FriendRequest.where('from_id = (?) AND to_id = (?)', params[:from_id], params[:to_id])[0].destroy
    redirect_to profile_path
  end

  private
  def send_notification
    Notification.create(classification: 'request', user_id: params[:to_id]) if User.find(params[:to_id]).notifications.where('classification = (?)', 'request').count == 0
  end

  def delete_notification
    notification = User.find(params[:to_id]).notifications.find_by(classification: 'request')
    notification.destroy unless notification.nil?
  end

end
