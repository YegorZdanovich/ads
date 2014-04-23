require 'spec_helper'

describe Category do
  
  subject {Category.create! value: "test category"}

  it 'should be valid' do
    subject.should be_valid
  end

  it 'should not be valid' do
    expect(Category.create value: "").to have(1).errors_on(:value)
  end

  it 'should be uniq' do
    category1 = Category.create value: "test category"
    category2 = Category.create value: "test category"

    expect(category2).to have(1).errors_on(:value)    
  end

end