require 'spec_helper'

describe 'Advertisement' do

  before(:all) do
    fill_ads_and_category_tables
  end

  after(:all) do
    clear_db(:advertisement, :category)
  end

  describe "Price" do

    before(:each) do
      visit root_path
    end

    it 'should be in asc order' do
      click_link "Sort by price"
      min_price = first('.ads-price').text.match('\d+').to_s.to_i
      Advertisement.published.pluck(:price).min.should == min_price
    end

    it 'should be in desc order' do
      click_link "Sort by price"
      click_link "Sort by price"
      max_price = first('.ads-price').text.match('\d+').to_s.to_i
      Advertisement.published.pluck(:price).max.should == max_price
    end
  end

  describe "Publication Time" do

    before(:each) do
      visit root_path
    end

    it 'should be in asc order' do
      click_link "Sort by publication time"
      min_time = first('.ads-time').text
      time = Advertisement.published.pluck(:updated_at).min
      string_time = "Publication Time: #{time.to_time.strftime("%H:%M:%S %d-%m-%Y")}"
      string_time.should == min_time
    end

    it 'should be in desc order' do
      click_link "Sort by publication time"
      click_link "Sort by publication time"
      max_time = first('.ads-time').text
      time = Advertisement.published.pluck(:updated_at).max
      string_time = "Publication Time: #{time.to_time.strftime("%H:%M:%S %d-%m-%Y")}"
      string_time.should == max_time
    end

  end

end
