FactoryGirl.define do
  
  factory :user do
    email "user1@gmail.com"
    password "user112345"
    role "user"
  end

  factory :admin, class: User do
    email "yegor.zdanovich@gmail.com"
    password "yegor12345"
    role "admin"
  end

  factory :category do
    value "test vategory"
  end

  factory :advertisement do
    category "category test"
    title "title test"
    text "text test"
    price "10"
    contact "93458309"
    status "draft"
  end

end