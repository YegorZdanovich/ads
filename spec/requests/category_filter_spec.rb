require 'spec_helper'

describe 'Category' do
  
  it 'should have same count of ads' do
    visit root_path
    category =  first('.category-list').text
    click_link category
    ads_count = page.all('.ads').count
    Category.find_by(value: category).advertisements.published.count.should == ads_count
  end

  it 'should have ads with same category or be empty' do
    visit root_path
    category =  first('.category-list').text
    click_link category
    ads_count = page.all('.ads').count

    # if not empty
    unless ads_count == 0
      first('.ads-category').text.should == "Category: #{category}"
    end
  end

end