require 'spec_helper'

describe "ShowAliases" do
  describe "GET /show_aliases" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get show_aliases_path
      response.status.should be(200)
    end
  end
end
