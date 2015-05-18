class MessagesController < ApplicationController
  before_action :valid_user_and_dialog, only: [:create]
  before_action :is_logged_in?

  def create
    @message = Message.new(message_params)
    if @message.save
      PrivatePub.publish_to("/dialogs/#{params[:message][:dialog_id]}", message: {content: @message.content, from: @message.user.username})
    end
    respond_to do |format|
      format.js
    end
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
end
