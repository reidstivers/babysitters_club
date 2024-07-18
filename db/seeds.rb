# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Seeding listings for use in the index

20.times do
  listing = Listing.create(
    user_id: rand(1...(User.all.size)),
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph_by_chars(number: 50, supplemental: false),
    fee: Faker::Number.decimal(l_digits: 2),
    location: Faker::Address.full_address,
  )
  file = URI.open(Faker::LoremFlickr.image(size: "300x300"))
  listing.photos.attach(io: file, filename: 'listing.jpg', content_type: 'image/jpg')
end
