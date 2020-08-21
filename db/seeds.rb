require 'faker'
require 'open-uri'

puts 'Creating Users...'

users_to_create = 10

users_to_create.times do
  User.create(first_name: Faker::Name.first_name,
             last_name: Faker::Name.last_name,
             email: Faker::Internet.email,
             password: '123123',
             address: Faker::Address.city,
             phone_number: Faker::PhoneNumber.cell_phone)
end

puts "Users created: #{User.all.count}"
puts ""

puts 'Creating Categories...'

categories = [
  ["Environment", "fas fa-leaf"],
  ["Animal", "fas fa-paw"],
  ["Elderly and Disabled", "fas fa-wheelchair"],
  ["Children and Young People" ,"fas fa-baby"],
  ["Homeless", "fas fa-house-damage"],
  ["Education", "fas fa-book-open"],
  ["Health", "fas fa-heartbeat"],
  ["Culture", "fas fa-music"],
  ["Other", "fas fa-minus"]
]

categories.each do |category|
  new_category = Category.new(name: category[0], icon: category[1])
  new_category.save

  puts "Created the Category: #{new_category.name}"
end

puts "Categories created: #{Category.all.count}"
puts ""


puts 'Creating Organizations...'

organizations_photos_url = [
  'https://images.unsplash.com/photo-1570358934836-6802981e481e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1510395839401-f2ec7a07bbb5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1594750852517-f37738fa2384?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1110&q=80',
  'https://images.unsplash.com/photo-1569385210018-127685230669?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1521510186458-bbbda7aef46b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/flagged/photo-1576784188474-db03a2d80fca?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1584060713648-8f1cc8fc1e5a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1564974944378-7f6b56fea4a2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1588959570984-9f1e0e9a91a6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80',
  'https://images.unsplash.com/photo-1571115355423-1d318bd95e22?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1100&q=80'
  ]

organizations_photos_url.each do |url|
  new_org = Organization.new(name: Faker::Company.name,
                          address: Faker::Address.street_address,
                          email: Faker::Internet.email,
                          phone_number: Faker::PhoneNumber.cell_phone,
                          description: Faker::Lorem.paragraph,
                          category: Category.all.sample,
                          city: Faker::Address.city,
                          zip_code: Faker::Address.zip_code,
                          country: Faker::Address.country)

  file_photo = URI.open(url)
  new_org.photos.attach(io: file_photo, filename: 'nes.png', content_type: 'image/png')

  file_avatar = URI.open(url)
  new_org.avatar.attach(io: file_avatar, filename: 'nes.png', content_type: 'image/png')

  new_org.save
  
  puts "Created the Organization: #{new_org.name}"

  new_admin = Admin.new(user: User.all.sample, 
      organization: new_org, 
      can_edit: true,
      can_add_posts: true,
      can_add_events: true,
      can_add_admin: true,
      is_owner: true)

  new_admin.save

  puts "Linked the User #{new_admin.user.email} to #{new_admin.organization.name} as owner"


  new_post = Post.new(organization: new_org,
                    title: Faker::Company.name,
                    date: Faker::Date.backward(days: 14),
                    description: Faker::Lorem.paragraph,
                    location: Faker::Address.street_address)

  new_post.save

  puts "Created the Post: #{new_post.title} in #{new_post.organization.name}"


  new_event = Event.new(organization: new_org,
                      title: Faker::BossaNova.song,
                      date: Faker::Date.forward(days: 10),
                      description: Faker::Lorem.paragraph,
                      location: Faker::Address.street_address,
                      part_count: Faker::Number.between(from: 1, to: 100))

  new_event.save

  puts "Created the Event: #{new_event.title} in #{new_event.organization.name}"
  puts ""
end

puts "Organizations created: #{Organization.all.count}"
puts "Posts created: #{Post.all.count}"
puts "Events created: #{Event.all.count}"
puts ""
puts "Finished!"
