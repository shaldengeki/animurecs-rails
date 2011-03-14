class TaggingsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  # GET /taggings
  # GET /taggings.xml
  def index
    @taggings = Tagging.all
	@title = "Taggings"

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
	@title = "Tagging " + @tag.name + "-" + @show.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tagging }
    end
  end

  # GET /taggings/new
  # GET /taggings/new.xml
  def new
    @tagging = Tagging.new
	@title = "New tagging"
	
	unless params[:show_id].nil?
		@show = Show.find(params[:show_id])
		@tagging.show_id = @show.id
	else
		@show = Show.first
	end
	@tagging.tagtext = ""

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
	@title = "Editing " + @tag.name + "-" + @show.name
  end

  # POST /taggings
  # POST /taggings.xml
  def create
	# process the tag to see if we have a text tagtype in there.
	if params[:tagging][:tagtext].include? ":"
		# lop off the first bit as the tag type and the second bit as the actual tag name.
		tagarray = params[:tagging][:tagtext].split(":")
		if Tagtype.find_by_name(tagarray[0])
			tagtype_id = Tagtype.find_by_name(tagarray[0]).id
			tagtext = tagarray.last(tagarray.length-1).join(":")
		else
			tagtype_id = Tagtype.find_by_name("general")
			tagtext = tagarray.last(tagarray.length).join(":")
		end
	else
		tagtype_id = Tagtype.find_by_name("general").id
		tagtext = params[:tagging][:tagtext]
	end
	# save this tag into the db, if it doesn't already exist.
	oldtag = Tag.find_by_name(tagtext)
	if oldtag.nil? 
		newtag = Tag.new(:name => tagtext, :description => "", :tagtype_id => tagtype_id)
		newtag.save
	else
		newtag = oldtag
	end
	# now set the tag id in params and save this as a new tag.
	params[:tagging][:tag_id] = newtag.id
	@tagging = Tagging.new(params[:tagging])
	@show = Show.find(@tagging.show_id)
	
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
