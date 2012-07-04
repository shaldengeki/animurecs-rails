require "spec_helper"

describe ListEntriesController do
  describe "routing" do

    it "routes to #index" do
      get("/list_entries").should route_to("list_entries#index")
    end

    it "routes to #new" do
      get("/list_entries/new").should route_to("list_entries#new")
    end

    it "routes to #show" do
      get("/list_entries/1").should route_to("list_entries#show", :id => "1")
    end

    it "routes to #edit" do
      get("/list_entries/1/edit").should route_to("list_entries#edit", :id => "1")
    end

    it "routes to #create" do
      post("/list_entries").should route_to("list_entries#create")
    end

    it "routes to #update" do
      put("/list_entries/1").should route_to("list_entries#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/list_entries/1").should route_to("list_entries#destroy", :id => "1")
    end

  end
end
