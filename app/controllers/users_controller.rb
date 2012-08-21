class UsersController < ApplicationController
  load_and_authorize_resource

  # Displays list of users.
  # Can be accessed by GETting /users or  /users.xml
  def index
    @title = "All users"
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users.to_xml(:except => [:password_digest, :remember_token])}
    end
  end

  # Displays a user's information.
  # Can be accessed by GETting /users/1 or  /users/1.xml
  def show
    @user = User.find(params[:id])
    @title = @user.username

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user.to_xml(:except => [:password_digest, :remember_token])}
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
    if params[:user][:password].blank? or params[:user][:password_confirmation].blank?
      sign_in_user = true
    else
      sign_in_user = false
    end
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    params[:user].delete(:avatar) if params[:user][:avatar].blank?
    if can? :update, Userrole
      params[:foo] = params[:user][:userrole_ids]
      params[:user][:userrole_ids].each do |new_userrole_id|
        unless new_userrole_id.blank?
          new_userrole = Userrole.find(new_userrole_id)
          @user.userroles << new_userrole unless @user.userroles.include?(new_userrole)
        end
      end
      @user.save
      params[:user].delete(:userrole_ids)
    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        pronoun = ' ' + @user.username
        pronoun_possessive = @user.username + "'s'"
        redirect_notice = ' will need to log in again.'
        if current_user?(@user)
          pronoun = ' You'
          pronoun_possessive = "Your"
        end
        if sign_in_user
          sign_in @user if current_user?(@user)
          pronoun = ''
          redirect_notice = ''
        end
        format.html { redirect_to(@user, :notice => pronoun_possessive + ' information has been updated.' + pronoun + redirect_notice) }
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
