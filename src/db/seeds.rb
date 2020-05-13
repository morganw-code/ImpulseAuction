Listing.destroy_all()

for i in 1000.times do
    active = [1, 2].sample
    Listing.create(
        :title => Faker::Commerce.product_name,
        :description => "lorem ipsum",
        :active => active,
        # trick the scheduler task
        :fire_time => Time.now + rand(1000).seconds,
        :sold => 0,
        :relist => 1,
        :starting_price => rand(500)
    )
end
