require 'rufus-scheduler'
scheduler = Rufus::Scheduler::singleton

scheduler.every '1s' do
    @listings = Listing.all
    for listing in @listings
        # check if listing has been up for more than 40 seconds
        if(listing.active == 1 && listing.updated_at < 40.seconds.ago)
            listing.update(active: 2) # set listing as ending soon
        # check if an additional 20 seconds has passed since update
        elsif(listing.active == 2 && listing.updated_at < 20.seconds.ago)
            listing.update(active: 0) # set listing as ended
        end
    end
end