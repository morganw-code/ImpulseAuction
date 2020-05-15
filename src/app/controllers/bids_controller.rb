class BidsController < ApplicationController
    def bid
        @listing = Listing.find_by_id(params[:id])
        if((@listing.active == 1 || @listing.active == 2))
            @listing.bids.create(:user => current_user, :amount => @listing.starting_price + 100)
            @listing.update(:starting_price => @listing.bids.find_by_user_id(current_user).amount) # $1
        else
            render plain: "Listing is no longer available, sorry!"
        end
    end
end