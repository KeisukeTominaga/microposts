class UsersController < ApplicationController
  #ログインしているか確認
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  def new
    @user = User.new
  end
  
  def create
    #binding.pry
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      
      #sitnup後自動的にログイン
      session[:user_id] = @user.id
      flash[:success]= "logged in as #{@user.name}"

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
  
  def favorites
    @user = User.find(params[:id])
    @favorites = current_user.favorite_microposts.all
  end
  
  def edit
    #binding.pry
    @user = User.find(params[:id])
    if current_user == @user
      render "edit"
    else
      flash[:danger] = "You do not have permission"
      redirect_to root_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if current_user == @user
      
      if @user.update(user_params)
        flash[:success] = "Your profile has been updated"
        redirect_to @user
      else
        render "edit"
      end
      
    else
      flash[:danger] = "You do not have permission"
      redirect_to root_path
    end
  end
    
    
  def destroy
    @user = User.find(params[:id])
    if current_user == @user
        @user.destroy
        flash[:success] = "Your account has been deleted"
        redirect_to root_url
    else
      flash[:danger] = "You do not have permission"
      redirect_to root_path
    end
  end
    
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :gender, :address, :password, :password_confirmation)
  end
  
  
end
