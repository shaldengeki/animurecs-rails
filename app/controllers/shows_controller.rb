class ShowsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]
  # GET /shows
  # GET /shows.xml
  def index
	if params[:tags].blank?
		# if tags blank, display all shows.
#		@shows = Show.find(:all).sort!{|t1,t2|t1.downvotes-t1.upvotes<=>t2.downvotes-t2.upvotes}
		@shows = Show.all.sort{|t1,t2|t1.downvotes-t1.upvotes<=>t2.downvotes-t2.upvotes}.paginate(:page => params[:page])
	else
		@shows = Array.new
		# if tags non-blank, get a list of shows to display.
		tags = params[:tags].split(" ")
		# assemble a list of show ids for each tag provided.
		i = 0
		all_shows_array = Array.new
		not_shows_array = Array.new
		or_shows_array = Array.new
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
			if tag_name[0].chr =~ /[\-\+\~]/
				short_tag_name = tag_name[1,tag_name.length-1]
			else
				short_tag_name = tag_name
			end
			
			tag = Tag.where(:name => short_tag_name).limit(1)
			if !tag.empty?
				taggings = Tagging.where(:tag_id => tag.first.id)
				j = 0
				shows_array = Array.new
				while j < taggings.length
					shows_array.push(taggings[j].show_id)
					j += 1
				end
				# if user has specified NOT, then push this onto the list of shows not to display.
				if tag_name[0].chr == "-"
					not_shows_array.push(shows_array)
				elsif tag_name[0].chr == "~"
					or_shows_array.push(shows_array)
				else
					all_shows_array.push(shows_array)
				end
			end
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
		@shows = @shows.paginate(:page => params[:page])
	end
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
      deny_access unless admin_user?
    end
end
