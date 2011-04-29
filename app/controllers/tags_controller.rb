class TagsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  # GET /tags
  # GET /tags.xml
  def index
    @tags = Tag.all.sort_by(&:name).paginate(:page => params[:page])
	@title = "Tags"
	@tagtypes = Tagtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    @tag = Tag.find(params[:id])
	@title = @tag.name
	@taggings = Tagging.where(:tag_id => @tag.id).paginate(:page => params[:page])
	@tagtypes = Tagtype.all
	# get popular related tags for this tag.
	@popularTags = Hash.new(0)
	@taggings.each{|tagging| Tagging.where(:show_id => tagging.show_id).each{|newTagging| @popularTags[newTagging.tag_id] += 1}}
#	Tagging.where(:tag_id => @tag.id).each{|tagging| Tagging.where(:show_id => tagging.show_id).each{|newTagging| @popularTags[newTagging.tag_id] = Tagging.count(:conditions => "`tag_id` = " + newTagging.tag_id.to_s)}}
	@popularTags = @popularTags.sort_by{|key,value| value}.reverse.take(25)


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    @tag = Tag.new
	@title = "New tag"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
	@title = "Editing " + @tag.name
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])
	# process the tagname to see if we have a tagtype in there.
	if @tag.name.include? ":"
		# lop off the first bit as the tag type and the second bit as the actual tag name.
		tagarray = @tag.name.split(":")
		if Tagtype.find_by_name(tagarray[0])
			@tag.tagtype_id = Tagtype.find_by_name(tagarray[0]).id
			@tag.name = tagarray.last(tagarray.length-1).join(":")
		end
	end

    respond_to do |format|
      if @tag.save
        format.html { redirect_to(@tag, :notice => 'Tag was successfully created.') }
        format.xml  { render :xml => @tag, :status => :created, :location => @tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to(@tag, :notice => 'Tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to(tags_url) }
      format.xml  { head :ok }
    end
  end
  private

    def authenticate
      deny_access unless signed_in?
    end
end
