class ListingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_listing, :only => [:show, :destroy, :edit, :add_favourite]
    
    def index
        @listings = Listing.all()
        Money.locale_backend = :i18n
    end

    def create
        @listing = current_user.listings.create(listing_params)
        @listing.update(
            :active => 1,
            :relist => true,
            :fire_at => Time.now,
            :sold => false
        )
        if @listing.errors.any?
            render "new"
        else
            redirect_to :root
        end
    end

    def show
    end

    def destroy
        # check if the user responsible for the action owns the listing
        if(current_user.id == @listing.user_id)
            @listing.destroy()

            redirect_back fallback_location: root_path
        else
            render plain: ":("
        end
    end

    def edit
    end

    def new
        @listing = Listing.new()
    end

    def add_favourite
        # check if user already has a favourite on the listing
        if(!@listing.favourites.find_by_user_id(current_user))
            @listing.favourites.create(:user => current_user)
            redirect_to :root, :notice => "Favourite created!"
        else
            @listing.favourites.find_by_user_id(current_user).destroy()
            redirect_to :root, :notice => "Favourite removed!"
        end
    end

    private

    def set_listing
        @listing = Listing.find_by_id(params[:id])
    end

    def listing_params
        params.require(:listing).permit(:title, :description, :starting_price, :image, :relist)
    end
end