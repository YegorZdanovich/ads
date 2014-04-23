require 'spec_helper'


describe Advertisement do



  subject do
    Advertisement.create  title: "test_titlesfdjhf",
                          text: "test text qweqwe",
                          contact: "123322 +"
  end

  it 'shoud be valid' do
    subject.should be_valid
  end

  it 'should not be valid' do
    @ads = Advertisement.create text: "test text qweqwe",
                                  contact: "123322 +"
    expect(@ads.errors_on(:title)).to include("can't be blank")
  end

  it 'should have contact length limit' do
    @ads = Advertisement.create title: "test title",
                                text: "test text qweqwe",
                                contact: "1233210937418734197340197304917490730937019374019343413408798"
    expect(@ads).to have(1).errors_on(:contact)
  end

  it 'should have category' do
    category = Category.create! value: "category test"
    category.advertisements << subject
    subject.category.value.should == category.value
  end

end