require "spec_helper"

describe ShowAliasesController do
  describe "routing" do

    it "routes to #index" do
      get("/show_aliases").should route_to("show_aliases#index")
    end

    it "routes to #new" do
      get("/show_aliases/new").should route_to("show_aliases#new")
    end

    it "routes to #show" do
      get("/show_aliases/1").should route_to("show_aliases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/show_aliases/1/edit").should route_to("show_aliases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/show_aliases").should route_to("show_aliases#create")
    end

    it "routes to #update" do
      put("/show_aliases/1").should route_to("show_aliases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/show_aliases/1").should route_to("show_aliases#destroy", :id => "1")
    end

  end
end
