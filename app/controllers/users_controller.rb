class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]

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
	
	# new users are ALWAYS normal users.
	@user.userlevel = 0;

    respond_to do |format|
      if @user.save
		sign_in @user
        format.html { redirect_to(@user, :notice => 'Welcome to LL Animu Recommendations!') }
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
	
	# if user is trying to elevate privileges past their own userlevel, return error.
	if params[:user]["userlevel"].to_i > @current_user.userlevel
		format.html { render :action => "edit" }
		format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }		
	else
		respond_to do |format|
		  if @user.update_attributes(params[:user])
			format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
			format.xml  { head :ok }
		  else
			format.html { render :action => "edit" }
			format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
		  end
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
  private

    def authenticate
      @user = User.find(params[:id])
      redirect_to(root_path) unless ( current_user?(@user) || admin_user? )
#      deny_access unless signed_in?
    end
end
