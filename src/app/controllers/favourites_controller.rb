class FavouritesController < ApplicationController
    def destroy
        @favourite = Favourite.find_by_id(params[:id])

        # check if the user responsible for the action owns the listing
        if(current_user.id == @favourite.user_id)
            @favourite.destroy()

            if @favourite.errors.any?
                render :back
            end

            redirect_to :root
        else
            render plain: ":("
        end
    end
end