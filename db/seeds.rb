# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

users_to_create = 10

puts 'Creating Users ...'

users_to_create.times do
  User.create(first_name: Faker::Name.first_name,
             last_name: Faker::Name.last_name,
             email: Faker::Internet.email,
             password: '123123',
             address: Faker::Address.city,
             phone_number: Faker::PhoneNumber.cell_phone)
end

puts "Users created: #{User.all.count}"

organizations_photos_url = [
  'https://images.unsplash.com/photo-1562157646-4303261af91e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1573407947625-124549936954?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1554244933-d876deb6b2ff?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1592106680408-e7e63efbc7ba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1569385210018-127685230669?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1521510186458-bbbda7aef46b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/flagged/photo-1576784188474-db03a2d80fca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1584060713648-8f1cc8fc1e5a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1564974944378-7f6b56fea4a2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1588959570984-9f1e0e9a91a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1571115355423-1d318bd95e22?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80'
  ]

puts 'Creating organizations ...'
organizations_photos_url.each do |url|
  org = Organization.new(name: Faker::Company.name,
                      address: Faker::Address.street_address,
                      email: Faker::Internet.email,
                      phone_number: Faker::PhoneNumber.cell_phone,
                      description: Faker::Lorem.paragraph,
                      category: "Others",
                      city: Faker::Address.city,
                      zip_code: Faker::Address.zip_code,
                      country: Faker::Address.country)

  file = URI.open(url)
  org.photos.attach(io: file, filename: 'nes.png', content_type: 'image/png')

  puts "Creating #{org.name} ..."
  org.save!

  admin = Admin.new(user: User.all.sample, 
      organization: org, 
      can_edit: true,
      can_add_posts: true,
      can_add_events: true,
      can_add_admin: true,
      is_owner: true)

  puts "Linking user #{admin.user.email} to #{admin.organization.name} as owner ..."
  admin.save!

  posts = Post.new(organization: Organization.all.sample,
                    organization: org,
                    title: Faker::Company.name,
                    date: Faker::Date.backward(days: 14),
                    description: Faker::Lorem.paragraph,
                    location: Faker::Address.street_address)

  puts "Creating posts: #{posts.title} to #{posts.organization.name}..."
  posts.save

  puts "Posts: #{Post.all.count}"

  events = Event.new(organization: Organization.all.sample,
                  organization: org,
                  title: Faker::BossaNova.song,
                  date: Faker::Date.forward(days: 10),
                  description: Faker::Lorem.paragraph,
                  location: Faker::Address.street_address,
                  part_count: Faker::Number.between(from: 1, to: 100))

  puts "Creating events: #{events.title} to #{events.organization.name}..."
  events.save

  puts "Events: #{Event.all.count}"

end


puts "Organizations created: #{Organization.all.count}"


puts "Finished!"
