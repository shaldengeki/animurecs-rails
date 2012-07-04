# spec/models/show_spec.rb
require 'spec_helper'

describe Show do
  it "has a valid factory" do
    FactoryGirl.create(:show).should be_valid
  end
  it "is invalid without a name" do
    FactoryGirl.build(:show, name:nil).should_not be_valid
  end
  it "does not allow duplicate names" do
    show = Factory(:show)
    Factory(:show, name:"shaldengeki")
    Factory.build(:show, name:"shaldengeki").should_not be_valid
  end
  it "is invalid without a description" do
    FactoryGirl.build(:show, description:nil).should_not be_valid
  end
  it "is invalid without a length" do
    FactoryGirl.build(:show, length:nil).should_not be_valid
  end
  it "is invalid without an upvote count" do
    FactoryGirl.build(:show, upvotes:nil).should_not be_valid
  end
  it "is invalid with an out-of-range upvote count" do
    FactoryGirl.build(:show, upvotes:-1).should_not be_valid
  end
  it "is invalid without a downvote count" do
    FactoryGirl.build(:show, downvotes:nil).should_not be_valid
  end
  it "is invalid with an out-of-range downvote count" do
    FactoryGirl.build(:show, downvotes:-1).should_not be_valid
  end
  it "is valid without a link" do
    FactoryGirl.build(:show, link:nil).should be_valid
  end
end