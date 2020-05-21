class FavouritesController < ApplicationController
    before_action :authenticate_user!
    
    def destroy
        @favourite = Favourite.find_by_id(params[:id])

        # check if the user responsible for the action owns the listing
        if(current_user.id == @favourite.user_id)
            @favourite.destroy()

            redirect_back fallback_location: root_path
        else
            render plain: ":("
        end
    end
end