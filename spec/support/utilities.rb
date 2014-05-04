include ApplicationHelper

def sign_in(user={})
  visit user_session_path
  fill_in "Email", with: user[:email]
  fill_in "Password", with: user[:password]
  click_button "Sign in"
end

# category model should be after ads model in list
def clear_db(*list)
  list.each do |table_name|
    table_name.to_s.humanize.constantize.destroy_all
  end
end

def fill_ads_and_category_tables
  @category1 = Category.create! value: "test category11"
  @category2 = Category.create! value: "test category 12"

  10.times do |i|
    @ads = Advertisement.create! title: "test_titlesfdjhf",
                                 text: "test text qweqwe",
                                 contact: "123322 +",
                                 price: "rand(1..100)"
    @ads.status = "published"
    @ads.save!

    if i.even?
      @category1.advertisements << @ads
    else
      @category2.advertisements << @ads
    end
  end
end
