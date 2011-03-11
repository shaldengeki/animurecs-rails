class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  # GET /users
  # GET /users.xml
  def index
	@title = "All users"
    @users = User.all
	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
	@title = @user.username
	
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new
	@title = "Sign Up"
	
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @title = "Edit user"
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
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

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

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

  # DELETE /users/1
  # DELETE /users/1.xml
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
      deny_access unless signed_in?
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless ( current_user?(@user) || admin_user? )
    end
end
