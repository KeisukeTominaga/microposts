class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    #binding.pry
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  
  
  def following
    @user = User.find(params[:id])
    @following = current_user.following_users.all
  end
  
  def followers
    @user = User.find(params[:id])
    @follower = current_user.follower_users.all
  end
  
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  
end
