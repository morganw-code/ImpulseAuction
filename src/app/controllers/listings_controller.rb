class ListingsController < ApplicationController
    def index
        @listings = Listing.all()
    end

    def public_reload
        redirect_to "/"
    end
end