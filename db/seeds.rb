# run db:seed and then rake status:publish

# add images in real time
User.destroy_all
Advertisement.destroy_all
Category.destroy_all

#create ads categories
categories = ["want to buy smt", "want to sell smt", "apartments to let", "free consert"]
categories.count.times do|i|
  Category.create value: categories[i]
end

#create admin
admin = User.create email: "yegor.zdanovich@gmail.com",
                    password: "yegor12345"
admin.role = :admin
admin.save

#create users
emails = ["user1@gmail.com", "user2@gmail.com", "user3@gmail.com", "user4.gmail.com"]
passwords = ["user112345", "user212345", "user312345", "user412345"]
emails.count.times do |i|
  User.create email: emails[i],
              password: passwords[i]
end

#create advertisements
# and make relationships between categories
title = "It's title for "
text = " is number of ads. This is test advertisement and it's not very long :)"
contact = " 4 8 15 16 23 42. call me maybe"
types = ["buy", "sale", "exchange"]
ads_count = 50
ads_count.times do |i|
  ads = Advertisement.create title: title + "#{i}" + "ads",
                             text: "#{i}" + text,
                             contact: contact,
                             type: types[ i % 3],
                             price: rand(10..200)

  category_count = Category.count
  user_count = User.count
  Category.all[i % category_count].advertisements << ads
  User.all[(i+1) % category_count].advertisements << ads
end

# some manipulation with ads status
Advertisement.order("random()").limit(ads_count / 2).each do |ads|

  #change to new
  ads.create

  if ads.id.even?
    ads.approve
  else
    ads.cancel
  end
end

Advertisement.import