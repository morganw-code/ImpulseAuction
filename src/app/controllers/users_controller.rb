class UsersController < ApplicationController
    def show
        @user = User.find_by_id(params[:id])
        @listings = Listing.all()
        @favourites = Favourite.all()
    end

    def destroy
        @user = User.find_by_id(params[:id])

        # check if the user responsible for the action is allowed to delete said user
        is_allowed = User.find_by_id(current_user.id).admin || current_user.id == @user.id
        if(is_allowed)
            @user.destroy()

            render :back
        else
            render plain: ":("
        end
    end
end