class MessagesController < ApplicationController
  before_action :valid_user_and_dialog, only: [:create]
  before_action :is_logged_in?
  after_action :send_notifications, only: [:create]

  def create
    @message = Message.new(message_params)
    if @message.save
      Dialog.find(params[:message][:dialog_id]).update_attribute(:last_message_send, Time.zone.now)
      # Publish to channel. Used to implement real-time updates
      PrivatePub.publish_to("/dialogs/#{params[:message][:dialog_id]}", message: { content: @message.content, from: @message.user.username })
    end
    respond_to do |format|
      format.js
    end
  end

  def java_client
    @messages = Message.all
    render xml: @messages.to_xml
  end

  private
  def valid_user_and_dialog
    user = User.find_by(id: params[:message][:user_id])
    dialog = Dialog.find_by(id: params[:message][:dialog_id])
    redirect_to root_url unless dialog.members.include?(user) && user.dialogs.include?(dialog)
  end

  def message_params
    params.require(:message).permit(:user_id, :dialog_id, :content)
  end

  def send_notifications
    dialog = Dialog.find_by(id: params[:message][:dialog_id])
    users = dialog.members
    users.each do |user|
      next if user == User.find_by(id: params[:message][:user_id]) || user.notification_exists?(dialog)
      Notification.create(classification: 'message', user_id: user.id, dialog_id: dialog.id)
    end
  end
end
