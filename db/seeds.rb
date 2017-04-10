User.destroy_all
Boardcategory.destroy_all
Boardpost.destroy_all

users = []
categories = []

status = ["In a band", "Looking for a band", "Looking for casual jams", "Looking for paid gig"]
genres = ["Blues", "Rap", "Fuck Buckets", "Country", "Jazz", "Rock n Roll", "Twinkle Twinkle", "Metal"]
playables = ["Guitar", "Bass", "Drums", "Piano", "Sax", "Keys", "Obo"]
post_categories = ["Band looking for players", "Bands needed", "For sale", "Players looking for bands", "Players looking for jams", "Music services", "Paid gigs" ]

30.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password',
    username: Faker::StarWars.character,
    location: Faker::StarWars.planet,
    genre: genres.sample,
    music_links: "music_links",
    band_status: status.sample,
    slogan: Faker::StarWars.wookie_sentence,
    bio: Faker::ChuckNorris.fact,
    experience: "SOME BS",
    instruments: playables.sample,
  )
end

# post_categories.each do |category|
#   Boardcategory.create!(name: category)
# end

i = 1
30.times do
  Boardcategory.create!(name: "CATEGORY#{i}")
  i += 1
end

200.times do
  Boardpost.create!(title: "Title", content: "Content", boardcategory_id: rand(1..30), user_id: rand(1..30))
end
