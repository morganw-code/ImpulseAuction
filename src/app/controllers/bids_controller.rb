class BidsController < ApplicationController
    before_action :set_listing, :only => [:bid, :bidder_owns_listing?, :update_listing, :bid_amount, :listing_is_active?, :user_has_existing_bid? ]

    def bid
        # check if listing is active and if the user does not have an existing bid on the listing
        if(listing_is_active?() && !user_has_existing_bid?)
            @listing.bids.create(:user => current_user, :amount => bid_amount())
            update_listing()
        # check if listing is active and if the user does have an existing bid on the listing
        elsif(listing_is_active?() && user_has_existing_bid?)
            # check if the users existing bid is lower than the current price of the listing
            if(@listing.bids.find_by_user_id(current_user).amount < @listing.starting_price)
                @listing.bids.find_by_user_id(current_user).destroy()
                @listing.bids.create(
                    :user => current_user,
                    :amount => bid_amount()
                )
                update_listing()
            else
                render plain: "You are the highest bidder!"
            end
        else
            render plain: "Listing is no longer available, sorry!"
        end
    end

    private

    def set_listing
        @listing = Listing.find_by_id(params[:id])
    end

    def bidder_owns_listing?
        return @listing.user_id == current_user
    end

    def update_listing
        @listing.update(
            :starting_price => @listing.bids.find_by_user_id(current_user).amount
        )
    end

    def bid_amount
        return @listing.starting_price + 100 # add $1
    end

    def listing_is_active?
        return @listing.active == 1 || @listing.active == 2
    end

    def user_has_existing_bid?
        return @listing.bids.find_by_user_id(current_user)
    end
end