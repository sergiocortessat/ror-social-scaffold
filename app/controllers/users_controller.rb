class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friends = current_user.friendships.filter { |friend| friend if friend != current_user }
    @pending_requests = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end
end
