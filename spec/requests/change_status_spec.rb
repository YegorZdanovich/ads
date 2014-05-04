require 'spec_helper'

describe "Advertisement's status." do

  before(:all) do

    @ads = Advertisement.create! title: "test_titlesfdjhf",
                                 text: "test text qweqwe",
                                 contact: "123322 +"
    @category = Category.create! value: "test category1"
    @category.advertisements << @ads

    @user = User.create! email: "user1@gmail.com",
                            password: "user112345"
    @user.advertisements << @ads

    @admin = User.create! email: "admin@gmail.com",
                             password: "admin112345"

    @admin.role = "admin"
    @admin.save!
  end

  after(:all) do
    clear_db(:user, :advertisement, :category)
  end

  describe 'User' do
    it 'can change ads status to new' do
      sign_in(email: @user.email, password: @user.password)
      visit root_path
      click_link @user.email
      click_link @user.advertisements.draft.first.title
      select "new", from: 'advertisement[status]'
      click_button "Update"
      page.should have_content "Advertisement was successfully updated."
    end
  end


  describe 'Admin' do

    before(:all) do
      @ads.status = "new"
      @ads.save!
    end

    before(:each) do
      sign_in(email: @admin.email, password: @admin.password)
      visit admin_all_ads_path
      click_link @ads.title
    end

    it 'can change ads status to canceld' do
      select "canceled", from: 'advertisement[status]'
      click_button "Update Status"
      page.should have_content "Advertisement was successfully updated."
    end

    it 'can change ads status to approved' do
      select "approved", from: 'advertisement[status]'
      click_button "Update Status"
      page.should have_content "Advertisement was successfully updated."
    end
  end
end
