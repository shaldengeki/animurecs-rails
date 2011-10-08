class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  before_filter :admin_user, :only => [:edit, :update]
  
  # Displays list of comments.
  # Can be accessed by GETting /comments or  /comments.xml
  def index
	begin
		@comments = Comment.find(:all, :order => 'time DESC').paginate(:page => params[:page])
	rescue
		@comments = Hash.new
	end
	@title = "Comments"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # Displays a comment's information.
  # Can be accessed by GETting /comments/1 or  /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
    @user = @comment.user
	@title = "Comment by " + @user.username

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # Displays comment adding form.
  # Can be accessed by GETting /comments/new or /comments/new.xml
  def new
    @comment = Comment.new
	@title = "New comment"
	
	unless params[:show_id].nil?
		@show = Show.find(params[:show_id])
	else
		@show = Show.first
	end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # Displays comment editing form.
  # Can be accessed by GETting /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
	@show = Show.find(@comment.show_id)
	@title = "Editing comment"
	
  end

  # Creates a new comment.
  # Can be accessed by POSTing to /comments or /comments.xml
  def create
    @comment = Comment.new(params[:comment])
	@comment.time = Time.now.to_i;
	@show = Show.find(@comment.show_id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to(@show, :notice => 'Commented successfully.') }
        format.xml  { render :xml => @show, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" , :show_id => @show.id}
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Updates a comment with new details.
  # Can be accessed by PUTting to /comments/1 or /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
	@new_comment = params[:comment]
	@new_comment[:user_id] = @comment.user_id
	
    respond_to do |format|
      if @comment.update_attributes(@new_comment)
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Deletes a comment.
  # Can be accessed by DELETE-ing to /comments/1 or /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
  private

    def authenticate
      deny_access unless signed_in?
    end
    def admin_user
      deny_access unless admin_user?
    end
    def correct_user
      @user = User.find(Comment.find(params[:id]).user_id)
      redirect_to(root_path) unless ( current_user?(@user) || admin_user? )
    end
end
