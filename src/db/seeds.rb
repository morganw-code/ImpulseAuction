Listing.destroy_all()
User.destroy_all()

user = User.new
user.email = "admin@admin.com"
user.password = "admin123"
user.encrypted_password = "$2a$11$CGmdaAQM/m5DA9MwKJN5/eu1f9zzmVS1kb4WgP/6.ZOh.gGswWXIS"
user.save!

user.update(admin: true)

case Rails.env
when "development"
    id = User.find_by_email("admin@admin.com").id

    for i in 25.times do
        active = [1, 2].sample
        Listing.create(
            :title => Faker::Commerce.product_name,
            :description => "lorem ipsum",
            :active => active,
            :fire_at => Time.now - 20.seconds,
            :sold => 0,
            :relist => 1,
            :starting_price => rand(500),
            :user_id => id
        )
    end
end