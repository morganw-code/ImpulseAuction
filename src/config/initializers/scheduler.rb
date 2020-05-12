require 'rufus-scheduler'
scheduler = Rufus::Scheduler::singleton

scheduler.every '0.5s' do
    @listings = Listing.all
    #check if listing has been 
    for listing in @listings
        # check if listing has been up for more than 40 seconds
        if(listing.active == 1 && listing.fire_time < 40.seconds.ago)
            listing.update(active: 2, fire_time: Time.now) # set listing as ending soon
        # check if 20 seconds has passed since update
        elsif(listing.active == 2 && listing.fire_time < 20.seconds.ago)
            listing.update(active: 0, fire_time: Time.now) # set listing as ended
        # relist in 5 seconds
        elsif(listing.active == 0 && listing.fire_time < 5.seconds.ago)
            listing.update(active: 1, fire_time: Time.now)
        end
    end
end