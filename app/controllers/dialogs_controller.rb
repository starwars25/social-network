class DialogsController < ApplicationController
  before_action :is_logged_in?
  before_action :valid_user?, only: [:show]
  before_action :belongs_to_dialog?, only: [:quit]
  before_action :enough_members?, only: [:quit]
  before_action :user_is_normal?, only: [:quit]
  before_action :clear_notifications, only: [:show]

  def new

  end

  def create
    if params[:multi] == 'true' # Dialog with more than two members
      dialog = Dialog.create(name: params[:dialog][:name])
      input = params[:dialog][:string].split
      users = []
      creator = User.find_by(id: params[:dialog][:creator_id])
      if creator.nil?
        dialog.destroy
        flash.now[:danger] = 'Something wrong happened.'
        redirect_to root_url
      end
      users << creator

      input.each do |email|
        user = User.find_by(email: email)
        if user.nil? || user == creator
          dialog.destroy
          flash.now[:danger] = 'Wrong input'
          redirect_to root_url
          return
        end
        users << user
      end

      dialog.add_members users
      dialog.update_attribute(:last_message_send, Time.zone.now)
      redirect_to dialogs_user_path(current_user)
    else
      dialog = Dialog.create
      user_one = User.find_by(id: params[:from])
      user_two = User.find_by(id: params[:to])
      dialog.add_members([user_one, user_two])
      dialog.update_attribute(:name, "#{user_one.username} #{user_two.username}")
      dialog.update_attribute(:last_message_send, Time.zone.now)
      flash.now[:success] = 'Dialog successfully created!'
      redirect_to dialogs_user_path(current_user)
    end
  end

  def show
    @dialog = Dialog.find_by(id: params[:id])
    respond_to do |format|
      format.js
    end
  end


  def user # All dialogs which belong to current user
    @user = User.find_by(id: params[:id])
  end

  def quit
    dialog = Dialog.find_by(id: params[:dialog_id])
    user = User.find_by(id: params[:user_id])
    dialog.remove_member(user)
    redirect_to root_url
  end

  private
  def user_is_normal? # Protection
    unless current_user.id.to_s == params[:user_id]
      flash.now[:danger] = 'We think that you are a hacker'
      redirect_to root_url
    end
  end

  def valid_user?
    redirect_to root_url unless Dialog.find_by(id: params[:id]).members.include?(current_user)
  end

  def belongs_to_dialog?
    unless Dialog.find_by(id: params[:dialog_id]).members.include? User.find_by(id: params[:user_id])
      flash.now[:danger] = 'You are not a member of this dialog'
      redirect_to root_url
    end
  end

  def enough_members?
    unless Dialog.find_by(id: params[:dialog_id]).members.count > 2
      flash.now[:danger] = 'You cannot quit dialog with only two members'
      redirect_to root_url
    end
  end

  def clear_notifications
    Notification.where('user_id = (?) AND dialog_id = (?)', current_user.id, params[:id]).each do |n|
      n.destroy
    end

  end
end
