class DialogsController < ApplicationController
  before_action :is_logged_in?, except: [:create]

  def create
    dialog = Dialog.create
    user_one = User.find_by(id: params[:from])
    user_two = User.find_by(id: params[:to])
    dialog.add_members([user_one, user_two])
    dialog.update_attribute(:name, "#{user_one.username} #{user_two.username}")
    flash.now[:success] = 'Dialog successfully created!'
    redirect_to root_url
  end

  def show
    @dialog = Dialog.find_by(id: params[:id])
  end

  def destroy

  end

  def user
    @user = User.find_by(id: params[:id])
  end
end
