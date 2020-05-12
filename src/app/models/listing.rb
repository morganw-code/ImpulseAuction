class Listing < ApplicationRecord
    after_update :reload_page

    private
    def reload_page
    end
end
