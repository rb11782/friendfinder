class FriendsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @friends = Friend.all
  end

  def new
    @friend = Friend.new
  end

  def show
    @friend = Friend.find_by_id(params[:id])
    return render_not_found if @friend.blank?
  end

  def create
    @friend = current_user.friends.create(friend_params)
    if @friend.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @friend = Friend.find(params[:id])
    return render_not_found if @friend.blank?
    if @friend.user != current_user
    return render plain: 'Not Allowed', status: :forbidden
    end
  end

  def update
    @friend = Friend.find_by_id(params[:id])
     return render_not_found if @friend.blank?
     if @friend.user != current_user
      return render plain: 'Not Allowed', status: :forbidden
      end
    @friend.update_attributes(friend_params)
    if @friend.valid?
    redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @friend = Friend.find_by_id(params[:id])
     if @friend.user != current_user
    return render plain: 'Not Allowed', status: :forbidden
    end
    return render_not_found if @friend.blank?
    @friend.destroy
    redirect_to root_path
  end

  

  private

  def friend_params
    params.require(:friend).permit(:name, :address)
  end

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end

end
