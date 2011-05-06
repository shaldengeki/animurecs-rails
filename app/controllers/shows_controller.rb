class ShowsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  # GET /shows
  # GET /shows.xml
  def index
	page = params[:page].to_i; page = 1 if page == 0
	limit = 30
	@tagtypes = Tagtype.all
	@tags = Hash.new
	if params[:tags].blank?
		# if tags blank, display all shows.
#		@shows = Show.find(:all).sort!{|t1,t2|t1.downvotes-t1.upvotes<=>t2.downvotes-t2.upvotes}
#		@shows = Show.all.sort{|t1,t2|t1.downvotes-t1.upvotes<=>t2.downvotes-t2.upvotes}
		post_count = Show.count

		@shows = WillPaginate::Collection.create(page, limit, post_count) do |page|
			page.replace(Show.find_by_sql("SELECT * FROM `shows` ORDER BY `upvotes` - `downvotes` DESC LIMIT " + page.offset.to_s + "," + page.per_page.to_s))
		end
		relevantTaggings = Tagging.all		
	else
		@shows = Array.new
		# if tags non-blank, get a list of shows to display.
		tags = params[:tags].split(" ")
		# assemble a list of show ids for each tag provided.
		i = 0
		all_shows_array = Array.new
		not_shows_array = Array.new
		or_shows_array = Array.new
		show_title_array = Array.new
		while i < tags.length
			if tags[i].include? ":"
				# lop off the first bit as the tag type and the second bit as the actual tag name.
				tagarray = tags[i].split(":")
				if Tagtype.find_by_name(tagarray[0])
					tagtype_id = Tagtype.find_by_name(tagarray[0]).id
					tag_name = tagarray.last(tagarray.length-1).join(":")
				else
					# could not find this tag type. set tag type to general and tag name to blank, blanking the results.
					tagtype_id = Tagtype.find_by_name("general").id
					tag_name = ""
				end
			else
				# no tagtype. set type to general and tag name to the full string.
				tagtype_id = Tagtype.find_by_name("general").id
				tag_name = tags[i]
			end
			
			# check for control characters at the beginning of this tag and strip them if necessary.
			if !tag_name[0].nil? && tag_name[0].chr =~ /[\-\+\~]/
				short_tag_name = tag_name[1,tag_name.length-1]
			else
				short_tag_name = tag_name
			end
			
			tag = Tag.find_by_name(short_tag_name)
			if !tag.nil?
				taggings = Tagging.where(:tag_id => tag.id)
				j = 0
				shows_array = Array.new
				while j < taggings.length
					shows_array.push(taggings[j].show_id)
					j += 1
				end
				# if user has specified NOT, then push this onto the list of shows not to display.
				if !tag_name[0].nil? && tag_name[0].chr == "-"
					not_shows_array.push(shows_array)
				elsif !tag_name[0].nil? && tag_name[0].chr == "~"
					or_shows_array.push(shows_array)
				else
					all_shows_array.push(shows_array)
				end
			end
			# finally, get shows which have titles like this tag name.
			i += 1
		end		
		final_shows_array = Array.new
		
		# include all the shows in the OR array.
		i = 0
		while i < or_shows_array.length
			final_shows_array = final_shows_array | or_shows_array[i]
			i += 1
		end
		
		# intersect each of the lists in the ALL array.
		i = 0
		while i < all_shows_array.length
			if i == 0
				final_shows_array = all_shows_array[i]
			else
				final_shows_array = final_shows_array & all_shows_array[i]
			end
			i += 1
		end
		
		# exclude any of the shows in the NOT array.
		i = 0
		while i < not_shows_array.length
			final_shows_array = final_shows_array - not_shows_array[i]
			i += 1
		end
		# now get information for each of these shows.
		i = 0
		while i < final_shows_array.length
			@shows.push(Show.find(final_shows_array[i]))
			i += 1
		end
		relevantTaggings = Tagging.where(:show_id => @shows)
		@shows = @shows.paginate(:page => params[:page])		
	end

	# now get the most-frequently used tags in this group of shows.
	@popularTags = Hash.new(0)
	relevantTaggings.each{|tagging| @popularTags[tagging.tag_id] += 1}
	@popularTags = @popularTags.sort_by{|key,value| value}.reverse.take(25)

	@title = "Shows"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shows }
    end
  end

  # GET /shows/1
  # GET /shows/1.xml
  def show
    @show = Show.find(params[:id])
	@title = @show.name	
    @comments = @show.comments.sort_by(&:time).reverse
	@tagtypes = Tagtype.all
	@tags = Hash.new
	
	# get the tags for this show, and the number of posts which use each of these tags.
	@popularTags = Hash.new(0)
	Tagging.where(:show_id => @show).each{|tagging| @popularTags[tagging.tag_id] = Tagging.count(:conditions => "`tag_id` = " + tagging.tag_id.to_s)}
	@popularTags = @popularTags.sort_by{|key,value| value}.reverse.take(25)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @show }
    end
  end

  # GET /shows/new
  # GET /shows/new.xml
  def new
    @show = Show.new
	@title = "New show"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @show }
    end
  end

  # GET /shows/1/edit
  def edit
    @show = Show.find(params[:id])
	@title = "Editing " + @show.name
  end

  # POST /shows
  # POST /shows.xml
  def create
    @show = Show.new(params[:show])

    respond_to do |format|
      if @show.save
        format.html { redirect_to(@show, :notice => 'Show was successfully created.') }
        format.xml  { render :xml => @show, :status => :created, :location => @show }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shows/1
  # PUT /shows/1.xml
  def update
    @show = Show.find(params[:id])

    respond_to do |format|
      if @show.update_attributes(params[:show])
        format.html { redirect_to(@show, :notice => 'Show was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @show.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.xml
  def destroy
    @show = Show.find(params[:id])
    @show.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
      format.xml  { head :ok }
    end
  end
  private
    def authenticate
      deny_access unless moderator_user?
    end
end
