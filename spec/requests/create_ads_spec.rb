require 'spec_helper'

describe 'Ads' do

  before(:all) do
    @category = Category.create!(value: "test")
    @user = User.create! email: "user1@gmail.com",
                            password: "user112345"
    @admin = User.create! email: "admin@gmail.com",
                             password: "admin112345"

    @admin.role = "admin"
    @admin.save!
  end

  after(:all) do
    clear_db(:category, :user)
  end

  it 'can be created by user' do
    sign_in(email: @user.email, password: @user.password)
    visit new_advertisement_path
    select @category.value, from: "advertisement[category]"
    fill_in "advertisement_title", with: "title test"
    fill_in "advertisement_text", with: "text test"
    fill_in "advertisement_price", with: "10"
    fill_in "advertisement_contact", with: "911"
    click_button "Save"
    page.should have_content "Advertisement was successfully created."
  end

  it 'can not be create by admin' do
    sign_in(email: @admin.email, password: @admin.password)
    visit new_advertisement_path
    page.should have_content "Sorry bro, but you can't create new ads.."
  end

  it 'can not be cteate by guest' do
    visit root_path
    visit new_advertisement_path
    page.should have_content "Sorry bro, but you can't create new ads.."
  end

end
