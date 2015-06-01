class UsersController < ApplicationController
  before_action :is_logged_in?, except: [:new, :create, :edit, :update]

  def new
    @user = User.new
  end

  def index # All users
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def show
    @user = User.find_by(id: params[:id])
    @feed = @user.wall.paginate(page: params[:page], per_page: 10)
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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Successfully updated profile'
      redirect_to profile_path
    else
      flash.now[:danger] = 'Error'
      render 'users/edit'
    end
  end

  def unfriend # Remove friend
    User.find_by(id: params[:one]).unfriend(User.find_by(id: params[:two]))
    flash[:success] = 'Friend removed'
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar, :first_name,
                                 :last_name,
                                 :date_of_birth,
                                 :city,
                                 :country,
                                 :school,
                                 :university,
                                 :occupation)
  end


end
