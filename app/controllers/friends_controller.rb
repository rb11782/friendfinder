class FriendsController < ApplicationController

  def index
    @friends = Friend.all
  end

  def new
    @friend = Friend.new
  end

  def create
     Friend.create(friend_params)
     redirect_to root_path
  end

  private

  def friend_params
    params.require(:friend).permit(:name, :address)
  end

end
