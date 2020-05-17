class BidsController < ApplicationController
    def bid
        @listing = Listing.find_by_id(params[:id])
        # check if listing is active and if the user does not have an existing bid on the listing
        if(listing_is_active?(@listing) && !user_has_existing_bid?)
            @listing.bids.create(:user => current_user, :amount => bid_amount(@listing))
            update_listing(@listing)
        # check if listing is active and if the user does have an existing bid on the listing
        elsif(listing_is_active?(@listing) && user_has_existing_bid?)
            # check if the users existing bid is lower than the current price of the listing
            if(@listing.bids.find_by_user_id(current_user).amount < @listing.starting_price)
                @listing.bids.find_by_user_id(current_user).destroy()
                @listing.bids.create(
                    :user => current_user,
                    :amount => bid_amount(@listing)
                )
                update_listing(@listing)
            else
                render plain: "You are the highest bidder!"
            end
        else
            render plain: "Listing is no longer available, sorry!"
        end
    end

    private

    def update_listing(listing)
        listing.update(
            :starting_price => @listing.bids.find_by_user_id(current_user).amount
        )
    end

    def bid_amount(listing)
        return listing.starting_price + 100 # add $1
    end

    def listing_is_active?(listing)
        return @listing.active == 1 || @listing.active == 2
    end

    def user_has_existing_bid?
        return @listing.bids.find_by_user_id(current_user)
    end
end