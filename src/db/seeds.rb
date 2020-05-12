Listing.destroy_all()

# for i in 100.times do
#     active = rand(3)
#     Listing.create(
#         :title => Faker::Commerce.product_name,
#         :description => "lorem ipsum",
#         :active => active
#     )
# end

Listing.create(
    :title => Faker::Commerce.product_name,
    :description => "lorem ipsum",
    :active => 1
)