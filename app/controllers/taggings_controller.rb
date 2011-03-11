class TaggingsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  # GET /taggings
  # GET /taggings.xml
  def index
    @taggings = Tagging.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @taggings }
    end
  end

  # GET /taggings/1
  # GET /taggings/1.xml
  def show
    @tagging = Tagging.find(params[:id])
	@tag = Tag.find(@tagging.tag_id)
	@show = Show.find(@tagging.show_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tagging }
    end
  end

  # GET /taggings/new
  # GET /taggings/new.xml
  def new
    @tagging = Tagging.new
	unless params[:show_id].nil?
		@show = Show.find(params[:show_id])
		@tagging.show_id = @show.id
	else
		@show = Show.first
	end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tagging }
    end
  end

  # GET /taggings/1/edit
  def edit
    @tagging = Tagging.find(params[:id])
	@tag = Tag.find(@tagging.tag_id)
	@show = Show.find(@tagging.show_id)
  end

  # POST /taggings
  # POST /taggings.xml
  def create
    @tagging = Tagging.new(params[:tagging])

    respond_to do |format|
      if @tagging.save
        format.html { redirect_to(@tagging, :notice => 'Tagging was successfully created.') }
        format.xml  { render :xml => @tagging, :status => :created, :location => @tagging }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /taggings/1
  # PUT /taggings/1.xml
  def update
    @tagging = Tagging.find(params[:id])

    respond_to do |format|
      if @tagging.update_attributes(params[:tagging])
        format.html { redirect_to(@tagging, :notice => 'Tagging was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /taggings/1
  # DELETE /taggings/1.xml
  def destroy
    @tagging = Tagging.find(params[:id])
    @tagging.destroy

    respond_to do |format|
      format.html { redirect_to(taggings_url) }
      format.xml  { head :ok }
    end
  end
  private

    def authenticate
      deny_access unless signed_in?
    end
end
