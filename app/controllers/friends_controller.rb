class FriendsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @friends = Friend.all
  end

  def new
    @friend = Friend.new
  end

  def create
     current_user.friends.create(friend_params)
     redirect_to root_path
  end

  private

  def friend_params
    params.require(:friend).permit(:name, :address)
  end

end
