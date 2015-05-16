class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @friends = current_user.friends unless current_user.nil?
  end
end
