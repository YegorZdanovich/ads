require 'spec_helper'

describe User do

  it 'should be admin' do
    user =  User.create  email: "yegor@gmail.com",
                          password: "12345678"
    user.role = :admin
    user.save!
    user.role.should == "admin"
  end

  it 'should be user' do
    user =  User.create  email: "yegor@gmail.com",
                          password: "12345678"
    user.role.should == "user"
  end

  it 'should be guest' do
    user = User.new
    user.role.should == "guest"
  end

end