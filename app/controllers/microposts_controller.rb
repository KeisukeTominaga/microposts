class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  
  def show
    @micropost = Micropost.find(params[:id])
  end
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
        flash[:success] = "Micropost created!"
        redirect_to root_url
    else
        @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
        @paginate_items = @feed_items.page(params[:page])
        render "static_pages/home"
    end
  end
  
  def edit
    @user = Micropost.find(params[:id]).user
    
    if current_user == @user
      @micropost = current_user.microposts.find_by(id: params[:id])
      render "edit"
    else
      flash[:danger] = "不正なアクセス"
      redirect_to root_path
    end
  end
  
  def update
    @user = Micropost.find(params[:id]).user
    
    if current_user == @user
      @micropost = current_user.microposts.find_by(id: params[:id])
      
      if @micropost.update(micropost_params)
        flash[:success] = "Your micropost has been updated"
        redirect_to user_path(@micropost.user_id)
      else
        render "edit"
      end
      
    else
      flash[:danger] = "不正なアクセス"
      redirect_to root_path
    end
  end
  
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
    
end
