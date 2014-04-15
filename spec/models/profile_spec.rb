require 'spec_helper'

describe Profile do
  
  it 'belongs to user' do
    user = User.create email: "yegor@gmail.com",
                        password: "123123123"
    Profile.first.user_id.should == user.id
  end

  it 'should delet user when delet Profile' do
    user = User.create email: "yegor@gmail.com",
                       password: "123123123"

    User.first.destroy
    expect(Profile).to have(:no).records
  end
end