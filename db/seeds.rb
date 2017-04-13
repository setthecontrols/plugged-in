User.destroy_all
Boardcategory.destroy_all
Boardpost.destroy_all

users = []
categories = []

experience = ["Just started playing", "I play with friends a bit", "Playing local gigs", "Music's my job and life"]
status = ["In a band", "Looking for a band", "Looking for casual jams", "Looking for paid gig"]
genres = ["Blues", "Rap", "Fuck Buckets", "Country", "Jazz", "Rock n Roll", "Twinkle Twinkle", "Metal"]
playables = ["Guitar", "Bass", "Drums", "Piano", "Sax", "Keys", "Obo"]
post_categories = ["Band looking for players", "Bands needed", "For sale", "Players looking for bands", "Players looking for jams", "Music services", "Paid gigs" ]

200.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    username: Faker::StarWars.character,
    location: Faker::Address.zip,
    genre: genres.sample,
    music_links: "http://www.sweetsweetlove.com",
    band_status: status.sample,
    slogan: Faker::StarWars.wookie_sentence,
    bio: Faker::Lorem.paragraph,
    experience: experience.sample,
    instruments: playables.sample,
    avatar: Faker::LoremPixel.image("50x60", false, 'sports', 3),
    # avatar: Faker::Avatar.image("my-own-slug", "50x50", "bmp", "set1", "bg1"),

  )
end
users = User.all
user.each {|u| u << rand(1..150)}


post_categories.each do |category|
  Boardcategory.create!(name: category)
end


200.times do
  Boardpost.create!(title: "Title", content: "Content", boardcategory_id: rand(1..7), user_id: rand(1..30))
end
