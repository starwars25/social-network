class StaticPagesController < ApplicationController
  before_action :is_logged_in?

  def home
    @users = User.all
    @friends = current_user.friends unless current_user.nil?
    @user = current_user
  end

  def profile
    @user = current_user
  end
end
