Listing.destroy_all()
User.destroy_all()

user = User.new
user.email = "admin@admin.com"
user.password = "admin123"
user.encrypted_password = "$2a$11$CGmdaAQM/m5DA9MwKJN5/eu1f9zzmVS1kb4WgP/6.ZOh.gGswWXIS"
user.save!
User.first.update(admin: true)

id = User.find_by_email("admin@admin.com").id

for i in 1.times do
    active = [2].sample
    Listing.create(
        :title => Faker::Commerce.product_name,
        :description => "lorem ipsum",
        :active => active,
        # trick the scheduler task
        :fire_time => Time.now,
        :sold => 0,
        :relist => 1,
        :starting_price => rand(500),
        :user_id => id
    )
end
