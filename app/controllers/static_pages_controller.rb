class StaticPagesController < ApplicationController
  before_action :is_logged_in?

  def home
    @users = User.all
    @friends = current_user.friends unless current_user.nil?
  end

  def profile

  end
end
