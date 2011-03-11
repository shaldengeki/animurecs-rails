require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by the Rails when you ran the scaffold generator.

describe TagtypesController do

  def mock_tagtype(stubs={})
    @mock_tagtype ||= mock_model(Tagtype, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all tagtypes as @tagtypes" do
      Tagtype.stub(:all) { [mock_tagtype] }
      get :index
      assigns(:tagtypes).should eq([mock_tagtype])
    end
  end

  describe "GET show" do
    it "assigns the requested tagtype as @tagtype" do
      Tagtype.stub(:find).with("37") { mock_tagtype }
      get :show, :id => "37"
      assigns(:tagtype).should be(mock_tagtype)
    end
  end

  describe "GET new" do
    it "assigns a new tagtype as @tagtype" do
      Tagtype.stub(:new) { mock_tagtype }
      get :new
      assigns(:tagtype).should be(mock_tagtype)
    end
  end

  describe "GET edit" do
    it "assigns the requested tagtype as @tagtype" do
      Tagtype.stub(:find).with("37") { mock_tagtype }
      get :edit, :id => "37"
      assigns(:tagtype).should be(mock_tagtype)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created tagtype as @tagtype" do
        Tagtype.stub(:new).with({'these' => 'params'}) { mock_tagtype(:save => true) }
        post :create, :tagtype => {'these' => 'params'}
        assigns(:tagtype).should be(mock_tagtype)
      end

      it "redirects to the created tagtype" do
        Tagtype.stub(:new) { mock_tagtype(:save => true) }
        post :create, :tagtype => {}
        response.should redirect_to(tagtype_url(mock_tagtype))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tagtype as @tagtype" do
        Tagtype.stub(:new).with({'these' => 'params'}) { mock_tagtype(:save => false) }
        post :create, :tagtype => {'these' => 'params'}
        assigns(:tagtype).should be(mock_tagtype)
      end

      it "re-renders the 'new' template" do
        Tagtype.stub(:new) { mock_tagtype(:save => false) }
        post :create, :tagtype => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tagtype" do
        Tagtype.stub(:find).with("37") { mock_tagtype }
        mock_tagtype.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :tagtype => {'these' => 'params'}
      end

      it "assigns the requested tagtype as @tagtype" do
        Tagtype.stub(:find) { mock_tagtype(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:tagtype).should be(mock_tagtype)
      end

      it "redirects to the tagtype" do
        Tagtype.stub(:find) { mock_tagtype(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(tagtype_url(mock_tagtype))
      end
    end

    describe "with invalid params" do
      it "assigns the tagtype as @tagtype" do
        Tagtype.stub(:find) { mock_tagtype(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:tagtype).should be(mock_tagtype)
      end

      it "re-renders the 'edit' template" do
        Tagtype.stub(:find) { mock_tagtype(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tagtype" do
      Tagtype.stub(:find).with("37") { mock_tagtype }
      mock_tagtype.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the tagtypes list" do
      Tagtype.stub(:find) { mock_tagtype }
      delete :destroy, :id => "1"
      response.should redirect_to(tagtypes_url)
    end
  end

end
