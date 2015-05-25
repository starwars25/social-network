class StaticPagesController < ApplicationController
  before_action :is_logged_in?

  def home
    @users = User.all
    @friends = current_user.friends unless current_user.nil?
    @user = current_user
    @feed = current_user.feed.paginate(page: params[:page])
  end

  def profile
    @user = current_user
    @feed = current_user.wall.paginate(page: params[:page], per_page: 10)
  end
end
