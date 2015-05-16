class UsersController < ApplicationController
  before_action :is_logged_in?, only: [:show]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:success] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      flash[:danger] = 'Input is invalid.'
      render 'users/new'
    end
  end

  def unfriend
    User.find_by(id: params[:one]).unfriend(User.find_by(id: params[:two]))
    flash[:success] = 'Friend removed'
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end


end
