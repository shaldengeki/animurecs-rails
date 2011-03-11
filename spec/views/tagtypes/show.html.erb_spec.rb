require 'spec_helper'

describe "tagtypes/show.html.erb" do
  before(:each) do
    @tagtype = assign(:tagtype, stub_model(Tagtype,
      :name => "Name",
      :color => "Color"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Color/)
  end
end
