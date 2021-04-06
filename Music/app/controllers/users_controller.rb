class UsersController < ApplicationController

    before_action :require_logged_out, only: [:new, :create]   
    before_action :require_logged_in, only: [:index, :show]

    def show
        render :show
    end

    def new
        @user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save
            @user.activate!
            log_in_user!(@user)
            redirect_to root_url
            #---------------------
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end
end
