class DialogsController < ApplicationController
  def create
    dialog = Dialog.create
    user_one = User.find_by(id: params[:from])
    user_two = User.find_by(id: params[:to])
    dialog.add_members([user_one, user_two])
    dialog.update_attribute(:name, "#{user_one.username} #{user_two.username}")
    flash.now[:success] = 'Dialog successfully created!'
    redirect_to root_url
  end

  def destroy

  end
end
