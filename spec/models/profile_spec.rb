require 'spec_helper'

describe Profile do
  
  it 'belongs to user' do
    user = User.create email: "yegor@gmail.com",
                        password: "123123123"


    Profile.last.user_id.should == user.id
  end

  it 'should delet user when delet Profile' do
    before_count = Profile.count
    user = User.create email: "yegor@gmail.com",
                       password: "123123123"

    User.last.destroy
    expect(Profile).to have(before_count).records
  end
end