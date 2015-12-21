class UsersController < ApplicationController

  before_action :logged_in_user?, only: [:edit, :update, :destroy]
  
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
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user
      @user.update(user_params)
      flash[:success] = "Your profile has been updated"
      redirect_to @user
    else
      render "edit"
    end
  end
    
  def destroy
    @user = User.find(params[:id])
    if current_user == @user
        @user.destroy
        flash[:success] = "Your account has been deleted"
        redirect_to root_url
    end
  end
    
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  
end
