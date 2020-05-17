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

    def show
        @listing = Listing.find_by_id(params[:id])
    end

    def destroy
        @listing = Listing.find_by_id(params[:id])
        @listing.destroy()

        if @listing.errors.any?
            render plain: "error"
        else
            redirect_to :root
        end
    end

    def new
        @listing = Listing.new()
    end

    def create
        @listing = current_user.listings.create(listing_params)
        @listing.update(
            :active => 1,
            :relist => true,
            :fire_time => Time.now
        )
        if @listing.errors.any?
            render "new"
        else
            redirect_to :root
        end
    end

    private

    def listing_params
        params.require(:listing).permit(:title, :description, :starting_price)
    end
end