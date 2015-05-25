class PostsController < ApplicationController
  before_action :is_logged_in?
  before_action :valid_user?, only: [:destroy]

  def create
    user = User.find_by(id: params[:user][:id])
    @post = Post.new(from_id: params[:current_user][:id], to_id: params[:user][:id], content: params[:post][:content], image: params[:post][:image])
    if @post.save
      flash.now[:success] = 'Post successfully created.'
      PrivatePub.publish_to("/wall/#{user.id}", post: { content: @post.content, from: @post.from.username, image: @post.image.url })
    else
      flash.now[:danger] = 'An error occurred.'
    end
    redirect_to user
  end

  def destroy
    Post.find_by(id: params[:id]).destroy
    redirect_to root_url
  end

  private
  def valid_user?
    redirect_to root_url unless @current_user.id.to_s == params[:user] || Post.find_by(id: params[:id]).to.id.to_s == params[:user]
  end
end
