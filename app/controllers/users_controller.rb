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

  def confirm
    @user = User.find(params[:id])
    @friendship = current_user.inverse_friendships.find { |friendship| friendship.user == @user }
    @friendship.update(confirmed: true)
    Friendship.create!(friend_id: current_user.id,
                      user_id: @user.id,
                      confirmed: true)

    redirect_to root_path
    flash[:notice] = 'Friend request accepted'
  end

  def deny
    
  end
end
