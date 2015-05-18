class DialogsController < ApplicationController
  before_action :is_logged_in?


  def new

  end

  def create
    if params[:multi] == 'true'
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
      redirect_to dialog
    else
      dialog = Dialog.create
      user_one = User.find_by(id: params[:from])
      user_two = User.find_by(id: params[:to])
      dialog.add_members([user_one, user_two])
      dialog.update_attribute(:name, "#{user_one.username} #{user_two.username}")
      flash.now[:success] = 'Dialog successfully created!'
      redirect_to dialog
    end
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
