class TagsController < ApplicationController
  autocomplete :tag, :name
  before_filter :authenticate, :only => [:new, :create]
  before_filter :moderator, :only => [:edit, :update, :destroy]
  
  # Displays list of tags.
  # Can be accessed by GETting /tags or  /tags.xml
  def index
	@tags = Tag.paginate(:page => params[:page], :order => 'name ASC')
	@title = "Tags"
	@tagtypes = Tagtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

  # Displays a tag's information.
  # Can be accessed by GETting /tags/1 or  /tags/1.xml
  def show
    @tag = Tag.find(params[:id])
	params[:tags] = @tag.name
	@title = @tag.name
	@taggings = Tagging.paginate(:page => params[:page], 
									:conditions => { :tag_id => @tag.id })
	@tagtypes = Tagtype.all
	
	# get popular related tags for this tag.
	@popularTags = Hash.new(0)
#	@taggings.each{|tagging| Tagging.where(:show_id => tagging.show_id).each{|newTagging| @popularTags[newTagging.tag_id] += 1}}
	# TODO: make this not horrible.
	Tagging.where(:tag_id => @tag.id).each{|tagging| Tagging.where(:show_id => tagging.show_id).each{|newTagging| @popularTags[newTagging.tag_id] = Tagging.count(:conditions => "`tag_id` = " + newTagging.tag_id.to_s)}}
	@popularTags = @popularTags.sort_by{|key,value| value}.reverse.take(25)


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # Displays the form to add a new tag.
  # Can be accessed by GETting /tags/new or  /tags/new.xml
  def new
    @tag = Tag.new
	@title = "New tag"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tag }
    end
  end

  # Displays the form to edit a tag's information.
  # Can be accessed by GETting /tags/edit/1
  def edit
    @tag = Tag.find(params[:id])
	@title = "Editing " + @tag.name
  end

  # Creates a tag.
  # Can be accessed by POSTING /tags or  /tags.xml
  def create
    @tag = Tag.new(params[:tag])
	@tag.name.downcase!
	
	# process the tagname to see if we have a tagtype in there.
	if @tag.name.include? ":"
		# lop off the first bit as the tag type and the second bit as the actual tag name.
		tagarray = @tag.name.split(":")
		if Tagtype.find_by_name(tagarray[0])
			@tag.tagtype_id = Tagtype.find_by_name(tagarray[0]).id
			@tag.name = tagarray.last(tagarray.length-1).join(":")
		end
	end
	# replace all whitespace in this tag with underscores.
	@tag.name.gsub!(/\s+/, '_')

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

  # Updates a tag with new information.
  # Can be accessed by PUTting /tags/1 or  /tags/1.xml
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

  # Deletes a tag.
  # Can be accessed by DELETEing /tags/1 or  /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
	
	# destroy all taggings belonging to this tag.
	Tagging.destroy_all(:tag_id => @tag.id)
	
	# now destroy the tag itself.
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
    def moderator
      deny_access unless moderator_user?
    end
    def admin_user
      deny_access unless admin_user?
    end
end
