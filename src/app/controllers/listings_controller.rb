class ListingsController < ApplicationController
    def index
        @listings = Listing.all()
        Money.locale_backend = :i18n
    end

    def public_reload
        redirect_to "/"
    end
end