class UsersController < ApplicationController
  load_and_authorize_resource

  # Displays list of users.
  # Can be accessed by GETting /users or  /users.xml
  def index
    @title = "All users"
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users.to_xml(:except => [:encrypted_password, :salt])}
    end
  end

  # Displays a user's information.
  # Can be accessed by GETting /users/1 or  /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.username

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user.to_xml(:except => [:encrypted_password, :salt])}
    end
  end

  # Displays the form to add a new user.
  # Can be accessed by GETting /users/new or  /users/new.xml
  def new
    @user = User.new
    @title = "Sign Up"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # Displays the form to edit a user's information.
  # Can be accessed by GETting /users/edit/1
  def edit
    @title = "Edit user"
  end

  # Creates a user.
  # Can be accessed by POSTING /users or  /users.xml
  def create
    @user = User.new(params[:user])

    # initialize users with a list and a normal userrole.
    @user.lists.build
    @user.lists.each do |list|
      list[:user_id] = "some fake data here"
    end
    normal_userrole = Userrole.where(:name => "Normal").first
    @user.userroles << normal_userrole
    respond_to do |format|
      if @user.save
        sign_in @user
        format.html { redirect_to(@user, :notice => 'Welcome to Animurecs!') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        @title = "Sign up"
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates a user with new information.
  # Can be accessed by PUTting /users/1 or  /users/1.xml
  def update
    @user = User.find(params[:id])
    params[:user].delete(:id)
    params[:user].delete(:role_ids)
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    params[:user].delete(:avatar) if params[:user][:avatar].blank?

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Your information has been updated. You will need to log in again.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a user.
  # Can be accessed by DELETEing /users/1 or  /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
