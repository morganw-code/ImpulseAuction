require 'rufus-scheduler'
scheduler = Rufus::Scheduler::singleton

s = Rufus::Scheduler.singleton

s.every '1s' do
    @listings = Listing.all
    #check if listing has been 
    for listing in @listings
        # check if listing has been up for more than 40 seconds
        if(listing.active == 1 && Time.now > listing.fire_at + 40.seconds)
            # set listing as ending soon
            listing.update(
                :active => 2
            )
        # check if 20 seconds has passed since update and should sell the listing to a user
        elsif(listing.active == 2 && Time.now > listing.fire_at + 60.seconds && !listing.sold && listing.bids.count() > 0)
            # select the highest bid for the listing
            @bid = listing.bids.order(amount: :desc).first
            # create order
            listing.orders.create(:user => @bid.user)
            # set listing as ended & sold
            listing.update(
                :active => 0,
                :sold => true,
                :relist => true,
                :fire_at => Time.now
            )
        # check if 20 seconds has passed since update && !sold
        elsif(listing.active == 2 && Time.now > listing.fire_at + 60.seconds && !listing.sold)
            # set listing as ended
            listing.update(
                :active => 0,
                :fire_at => Time.now,
                :sold => false
            )
        # check if 5 seconds has passed since ended && listing should relist if not sold
        elsif(listing.active == 0 && listing.relist && !listing.sold && Time.now > listing.fire_at + 5.seconds)
            # relist
            listing.update(
                :active => 1,
                :fire_at => Time.now
            )
        end
    end
end