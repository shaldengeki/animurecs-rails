require "spec_helper"

describe TagtypesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/tagtypes" }.should route_to(:controller => "tagtypes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/tagtypes/new" }.should route_to(:controller => "tagtypes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/tagtypes/1" }.should route_to(:controller => "tagtypes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/tagtypes/1/edit" }.should route_to(:controller => "tagtypes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/tagtypes" }.should route_to(:controller => "tagtypes", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/tagtypes/1" }.should route_to(:controller => "tagtypes", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/tagtypes/1" }.should route_to(:controller => "tagtypes", :action => "destroy", :id => "1")
    end

  end
end
