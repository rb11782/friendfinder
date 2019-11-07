class FriendsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

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

  def edit
    @friend = Friend.find(params[:id])
  end

  def update
    @friend = Friend.find(params[:id])
    @friend.update_attributes(friend_params)
    redirect_to root_path
  end

  def show
    @friend = Friend.find(params[:id])
  end

  private

  def friend_params
    params.require(:friend).permit(:name, :address)
  end

end
