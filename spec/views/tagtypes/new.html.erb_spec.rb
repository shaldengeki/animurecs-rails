require 'spec_helper'

describe "tagtypes/new.html.erb" do
  before(:each) do
    assign(:tagtype, stub_model(Tagtype,
      :name => "MyString",
      :color => "MyString"
    ).as_new_record)
  end

  it "renders new tagtype form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tagtypes_path, :method => "post" do
      assert_select "input#tagtype_name", :name => "tagtype[name]"
      assert_select "input#tagtype_color", :name => "tagtype[color]"
    end
  end
end
