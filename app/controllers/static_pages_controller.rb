class StaticPagesController < ApplicationController
    def home
        if logged_in?
            #binding.pry
            @micropost = current_user.microposts.build
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
            @paginate_items = @feed_items.page(params[:page])
        end
    end
end