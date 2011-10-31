class ShowvotesController < ApplicationController
  before_filter :authenticate, :only => [:new, :edit, :create, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  before_filter :moderator, :only => [:index, :show]

  # Displays list of showvotes.
  # Can be accessed by GETting /showvotes or  /showvotes.xml
  def index
    @showvotes = Showvote.all
	@title = "Show votes"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @showvotes }
    end
  end

  # Displays a showvote's information.
  # Can be accessed by GETting /showvotes/1 or  /showvotes/1.xml
  def show
    @showvote = Showvote.find(params[:id])
	@user = User.find(@showvote.user_id)
	@show = Show.find(@showvote.show_id)
	@title = @user.username + "'s vote on " + @show.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @showvote }
    end
  end

  # Displays the form to add a new showvote.
  # Can be accessed by GETting /showvotes/new or  /showvotes/new.xml
  def new
    @showvote = Showvote.new
	@title = "New show vote"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @showvote }
    end
  end

  # Displays the form to edit a showvote's information.
  # Can be accessed by GETting /showvotes/edit/1
  def edit
    @showvote = Showvote.find(params[:id])
	@user = User.find(@showvote.user_id)
	@show = Show.find(@showvote.show_id)
	@title = "Editing "+@user.username+"'s vote on "+@show.name
  end
  
  # Creates a showvote if it does not already exist.
  # Updates the showvote if it already does exist.
  def voteOnShow

  end
  
  # Creates a showvote if it does not already exist.
  # Updates the showvote if it already does exist.
  # Can be accessed by POSTING /showvotes or  /showvotes.xml
  def create
    # check to make sure that this user is authorised to make this show vote.
    thisUser = User.find(params[:user_id])
    redirect_to(root_path) unless ( current_user?(thisUser) || admin_user? )
    
    @showvote = Showvote.where(:show_id => params[:show_id], :user_id => params[:user_id]).limit(1)
	
    if @showvote.length < 1
      # create this showvote.
      voteOnShow = Showvote.new(:show_id => params[:show_id], :user_id => params[:user_id], :vote => params[:vote_val]).save
      @show = Show.find(params[:show_id])
    else
      # update this showvote if it's changed.
      @showvote = @showvote[0]
      if @showvote.vote != params[:vote_val]
        voteOnShow = Showvote.find(@showvote.id).update_attributes(:show_id => params[:show_id], :user_id => params[:user_id], :vote => params[:vote_val])
        @showvote = Showvote.find(@showvote.id)
		@show = Show.find(params[:show_id])
      else
        voteOnShow = true
      end
    end
    respond_to do |format|
      if voteOnShow
        format.js
        format.html { redirect_to(@showvote, :notice => 'Show vote was successfully created.') }
        format.xml  { render :xml => @showvote, :status => :created, :location => @showvote }
      else
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @showvote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates a showvote with new information.
  # Can be accessed by PUTting /showvotes/1 or  /showvotes/1.xml
  def update
    @showvote = Showvote.find(params[:id])

    respond_to do |format|
      if @showvote.update_attributes(params[:showvote])
        format.html { redirect_to(@showvote, :notice => 'Show vote was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @showvote.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a showvote.
  # Can be accessed by DELETEing /showvotes/1 or  /showvotes/1.xml
  def destroy
    @showvote = Showvote.find(params[:id])
    @showvote.destroy

    respond_to do |format|
      format.html { redirect_to(showvotes_url) }
      format.xml  { head :ok }
    end
  end
  
  private

	def authenticate
	  deny_access unless signed_in?
	end
    def correct_user
      @user = User.find(Showvote.find(params[:id]).user_id)
      redirect_to(root_path) unless ( current_user?(@user) || admin_user? )
    end
    def moderator
      deny_access unless moderator_user?
    end
    def admin_user
      deny_access unless admin_user?
    end
end