class SearchsController < ApplicationController
  before_action :is_logged_in?

  def home

  end

  def find
    @user = User.find_by(email: params[:search][:email])
  end
end
