# spec/models/user_spec.rb
require 'spec_helper'

describe User do
  it "has a valid factory" do
    FactoryGirl.create(:user).should be_valid
  end
  it "is invalid without a username" do
    FactoryGirl.build(:user, username: nil).should_not be_valid
  end
  it "does not allow duplicate usernames" do
    user = Factory(:user)
    Factory(:user, username: "shaldengeki")
    Factory.build(:user, username: "shaldengeki").should_not be_valid
  end
  it "is invalid without a password" do
    FactoryGirl.build(:user, password:nil).should_not be_valid
  end
  it "is invalid without a userlevel" do
    FactoryGirl.build(:user, userlevel:nil).should_not be_valid
  end
  it "is invalid with an out-of-range userlevel" do
    FactoryGirl.build(:user, userlevel:-1).should_not be_valid
  end
  it "is valid without an age" do
    FactoryGirl.build(:user, age:nil).should be_valid
  end
  it "is invalid with an out-of-range age" do
    FactoryGirl.build(:user, age:-1).should_not be_valid
  end
  it "is valid without a gender" do
    FactoryGirl.build(:user, gender:nil).should be_valid
  end
  it "is valid without a description" do
    FactoryGirl.build(:user, description:nil).should be_valid
  end
end