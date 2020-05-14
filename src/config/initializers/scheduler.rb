require 'rufus-scheduler'
scheduler = Rufus::Scheduler::singleton

scheduler.every '1s' do
    @listings = Listing.all
    #check if listing has been 
    for listing in @listings
        # check if listing has been up for more than 40 seconds
        if(listing.active == 1 && Time.now > listing.fire_time + 40.seconds)
            # set listing as ending soon
            listing.update(
                :active => 2,
                :fire_time => Time.now
            )
        # check if 20 seconds has passed since update
        elsif(listing.active == 2 && Time.now > listing.fire_time + 20.seconds)
            # set listing as ended
            listing.update(
                :active => 0,
                :fire_time => Time.now
            )
        # check if 5 seconds has passed since ended && listing should relist
        elsif(listing.active == 0 && listing.relist == 1 && Time.now > listing.fire_time + 5.seconds)
            # relist
            listing.update(
                :active => 1,
                :sold => 0,
                :fire_time => Time.now
            )
        end
    end
end