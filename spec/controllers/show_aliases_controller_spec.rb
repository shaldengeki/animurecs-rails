require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ShowAliasesController do

  # This should return the minimal set of attributes required to create a valid
  # ShowAlias. As you add validations to ShowAlias, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ShowAliasesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all show_aliases as @show_aliases" do
      show_alias = ShowAlias.create! valid_attributes
      get :index, {}, valid_session
      assigns(:show_aliases).should eq([show_alias])
    end
  end

  describe "GET show" do
    it "assigns the requested show_alias as @show_alias" do
      show_alias = ShowAlias.create! valid_attributes
      get :show, {:id => show_alias.to_param}, valid_session
      assigns(:show_alias).should eq(show_alias)
    end
  end

  describe "GET new" do
    it "assigns a new show_alias as @show_alias" do
      get :new, {}, valid_session
      assigns(:show_alias).should be_a_new(ShowAlias)
    end
  end

  describe "GET edit" do
    it "assigns the requested show_alias as @show_alias" do
      show_alias = ShowAlias.create! valid_attributes
      get :edit, {:id => show_alias.to_param}, valid_session
      assigns(:show_alias).should eq(show_alias)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ShowAlias" do
        expect {
          post :create, {:show_alias => valid_attributes}, valid_session
        }.to change(ShowAlias, :count).by(1)
      end

      it "assigns a newly created show_alias as @show_alias" do
        post :create, {:show_alias => valid_attributes}, valid_session
        assigns(:show_alias).should be_a(ShowAlias)
        assigns(:show_alias).should be_persisted
      end

      it "redirects to the created show_alias" do
        post :create, {:show_alias => valid_attributes}, valid_session
        response.should redirect_to(ShowAlias.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved show_alias as @show_alias" do
        # Trigger the behavior that occurs when invalid params are submitted
        ShowAlias.any_instance.stub(:save).and_return(false)
        post :create, {:show_alias => {}}, valid_session
        assigns(:show_alias).should be_a_new(ShowAlias)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ShowAlias.any_instance.stub(:save).and_return(false)
        post :create, {:show_alias => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested show_alias" do
        show_alias = ShowAlias.create! valid_attributes
        # Assuming there are no other show_aliases in the database, this
        # specifies that the ShowAlias created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ShowAlias.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => show_alias.to_param, :show_alias => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested show_alias as @show_alias" do
        show_alias = ShowAlias.create! valid_attributes
        put :update, {:id => show_alias.to_param, :show_alias => valid_attributes}, valid_session
        assigns(:show_alias).should eq(show_alias)
      end

      it "redirects to the show_alias" do
        show_alias = ShowAlias.create! valid_attributes
        put :update, {:id => show_alias.to_param, :show_alias => valid_attributes}, valid_session
        response.should redirect_to(show_alias)
      end
    end

    describe "with invalid params" do
      it "assigns the show_alias as @show_alias" do
        show_alias = ShowAlias.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ShowAlias.any_instance.stub(:save).and_return(false)
        put :update, {:id => show_alias.to_param, :show_alias => {}}, valid_session
        assigns(:show_alias).should eq(show_alias)
      end

      it "re-renders the 'edit' template" do
        show_alias = ShowAlias.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ShowAlias.any_instance.stub(:save).and_return(false)
        put :update, {:id => show_alias.to_param, :show_alias => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested show_alias" do
      show_alias = ShowAlias.create! valid_attributes
      expect {
        delete :destroy, {:id => show_alias.to_param}, valid_session
      }.to change(ShowAlias, :count).by(-1)
    end

    it "redirects to the show_aliases list" do
      show_alias = ShowAlias.create! valid_attributes
      delete :destroy, {:id => show_alias.to_param}, valid_session
      response.should redirect_to(show_aliases_url)
    end
  end

end