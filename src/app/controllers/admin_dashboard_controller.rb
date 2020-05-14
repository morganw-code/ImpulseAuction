class AdminDashboardController < ApplicationController
    before_action :authenticate_user!

    before_action do 
        redirect_to :root unless current_user && current_user.admin
    end

    def index
        @listings = Listing.all()
        @users = User.all()
    end

    # for user specifically
    def destroy
        @user = User.find_by_id(params[:id])
        if(!@user.id == current_user.id)
            @user.destroy()
            if @user.errors.any?
                render :plain => "error!"
            else
                redirect_to :admin_dashboard
            end

        else
            render plain: "You can't delete your own account!"
        end
    end
end