require 'spec_helper'

describe "tagtypes/edit.html.erb" do
  before(:each) do
    @tagtype = assign(:tagtype, stub_model(Tagtype,
      :name => "MyString",
      :color => "MyString"
    ))
  end

  it "renders the edit tagtype form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tagtypes_path(@tagtype), :method => "post" do
      assert_select "input#tagtype_name", :name => "tagtype[name]"
      assert_select "input#tagtype_color", :name => "tagtype[color]"
    end
  end
end
