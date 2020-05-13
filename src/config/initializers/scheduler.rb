require 'rufus-scheduler'
scheduler = Rufus::Scheduler::singleton

scheduler.every '1s' do
    @listings = Listing.all
    #check if listing has been 
    for listing in @listings
        # check if listing has been up for more than 40 seconds
        if(listing.active == 1 && Time.now > listing.updated_at + 40.seconds)
            # set listing as ending soon
            listing.update(
                :active => 2,
            )
        end
        # check if 20 seconds has passed since update
        if(listing.active == 2 && Time.now > listing.updated_at + 20.seconds)
            # set listing as ended
            listing.update(
                :active => 0,
                :sold => 0
            )
        end
        # check if 5 seconds has passed since ended && listing should relist
        if(listing.active == 0 &&  listing.relist == 1 && Time.now > listing.updated_at + 5.seconds)
            # relist
            listing.update(
                :active => 1,
            )
        end
    end
end