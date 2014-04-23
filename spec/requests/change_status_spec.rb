require 'spec_helper'

describe "Advertisement's status." do
  

  category = Category.find_by(value: "test") || Category.create!(value: "test")
  let(:user) { FactoryGirl.build(:user)} 
  let(:admin) { FactoryGirl.build(:admin)} 

  describe 'User' do
    before do
      sign_in(email: user.email, password: user.password)
      visit root_path
      click_link user.email
      click_link User.find_by(email: user.email).advertisements.draft.first.title
    end

    it 'can change ads status to new' do
      select "new", from: 'advertisement[status]'
      click_button "Update"
      page.should have_content "Advertisement was successfully updated."
    end
  end


  describe 'Admin' do

    before(:each) do
      sign_in(email: admin.email, password: admin.password)
      # save_and_open_page      
      visit admin_all_ads_path
      click_link Advertisement.new_ads.first.title
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