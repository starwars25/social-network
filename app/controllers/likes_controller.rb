class LikesController < ApplicationController
  before_action :is_logged_in?
  before_action :already_liked?, only: [:create]

  def create
    @post = Post.find_by(id: params[:to_id])
    Like.create(from_id: params[:from_id], to_id: params[:to_id])
  end

  def destroy
    @post = Post.find_by(id: params[:to_id])
    Like.where('from_id = (?) AND to_id = (?)', params[:from_id], params[:to_id])[0].destroy
  end

  private
  def already_liked?
    redirect_to root_url if Post.find_by(id: params[:to_id]).liked?(User.find_by(id: params[:from_id]))
  end
end
