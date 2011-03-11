class CommentsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all, :order => 'time DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])
    @user = @comment.user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
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

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
	@show = Show.find(@comment.show_id)
  end

  # POST /comments
  # POST /comments.xml
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

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])
	
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
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
    def correct_user
      @user = User.find(Comment.find(params[:id]).user_id)
      redirect_to(root_path) unless ( current_user?(@user) || admin_user?(@user) )
    end
end
