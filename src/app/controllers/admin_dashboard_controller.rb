class AdminDashboardController < ApplicationController
    before_action :authenticate_user!
    before_action { redirect_to :root unless current_user && current_user.admin }

    def index
        @listings = Listing.all()
        @users = User.all()
    end
end