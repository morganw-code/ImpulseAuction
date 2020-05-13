class ListingsController < ApplicationController
    before_action :authenticate_user!

    def index
        @listings = Listing.all()
        Money.locale_backend = :i18n
    end

    def create
        @listing = current_user.listings.create(listing_params)
    
        if @listing.errors.any?
            render "new"
        else
            redirect_to listings_path
        end
    end

    private

    def listing_params
        params.require(:listing).permit(:title, :description, :starting_price, :picture)
    end
end