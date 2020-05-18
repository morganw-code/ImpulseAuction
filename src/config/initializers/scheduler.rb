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
                :active => 2
            )
        # check if 20 seconds has passed since update and should sell the listing to a user
        elsif(listing.active == 2 && Time.now > listing.fire_time + 60.seconds && !listing.sold && listing.bids.count() > 0)
            # select the highest bid for the listing
            @bid = listing.bids.order(amount: :desc).first
            listing.orders.create(:user => @bid.user)
            # set listing as ended & sold
            listing.update(
                :active => 0,
                :fire_time => Time.now,
                :sold => 1,
                :relist => 0
            )
        # check if 20 seconds has passed since update && !sold
        elsif(listing.active == 2 && Time.now > listing.fire_time + 60.seconds && !listing.sold)
            # set listing as ended
            listing.update(
                :active => 0,
                :fire_time => Time.now,
                :sold => 0
            )
        # check if 5 seconds has passed since ended && listing should relist if not sold
        elsif(listing.active == 0 && listing.relist && !listing.sold && Time.now > listing.fire_time + 5.seconds)
            # relist
            listing.update(
                :active => 1,
                :fire_time => Time.now
            )
        end
    end
end