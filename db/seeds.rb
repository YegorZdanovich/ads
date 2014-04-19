# run db:seed and then rake status:publish

# add images in real time
User.destroy_all
Advertisement.destroy_all
Type.destroy_all

#create ads types
types = ["want to buy smt", "want to sell smt", "apartments to let", "free consert"]
types.count.times do|i|
  Type.create value: types[i]
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
# and make relationships between types
title = "It's title for "
text = " is number of ads. This is test advertisement and it's not very long :)"
contact = " 4 8 15 16 23 42. call me maybe"
ads_count = 50
ads_count.times do |i|
  ads = Advertisement.create title: title + "#{i}" + "ads",
                             text: "#{i}" + text,
                             contact: contact

  type_count = Type.count
  user_count = User.count
  Type.all[i % type_count].advertisements << ads
  User.all[(i+1) % type_count].advertisements << ads
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