class ShowsController < ApplicationController
  load_and_authorize_resource

  require 'will_paginate/array'
  # Displays list of shows.
  # Can be accessed by GETting /shows or  /shows.xml
  # Takes an HTTP parameter, tags, which takes a list of tags to search for separated by plus signs.
  def index
	page = params[:page].to_i; page = 1 if page == 0
	@tagtypes = Tagtype.all
	@tags = Hash.new
	final_shows_array = Array.new
	
	if params[:tags].blank?
		# if tags blank, display all shows.
		@shows = Show.order('upvotes DESC, downvotes ASC').paginate(:page => params[:page])
	else
		@shows = Array.new
		# cast all tags to lowercase.
		# if tags non-blank, get a set of shows to display.
		tags = params[:tags].downcase.split(" ").to_set
		
		# assemble a list of show ids for each tag provided.
		all_shows_array = Array.new
		not_shows_array = Array.new

		for tagString in tags
			# check for control characters at the beginning of this tag and strip them if necessary.
			if !tagString[0].nil? && tagString[0].chr =~ /[\-\+\~]/
				control_character = tagString[0].chr
				short_tag_name = tagString[1,tagString.length-1]
			else
				control_character = ""
				short_tag_name = tagString
			end

			if short_tag_name.include? ":"
				# lop off the first bit as the tag type and the second bit as the actual tag name.
				tagarray = short_tag_name.split(":")
				find_tagtype_object = Tagtype.find_by_name(tagarray[0])
				if find_tagtype_object
					tagtype_id = find_tagtype_object.id
					tag_name = tagarray.last(tagarray.length-1).join(":")
				else
					# could not find this tag type. set tag type to general and tag name to blank, blanking the results.
					tagtype_id = 1
					tag_name = ""
				end
			else
				# no tagtype. set type to general and tag name to the full string.
				tagtype_id = 1
				tag_name = short_tag_name
			end
			
			# now get all of the taggings for this particular tag.
			tag = Tag.find_by_name(tag_name)
      show = Show.find_by_name(tag_name)
      if !show.nil?
        all_shows_array.push(show.id)
      end
			if !tag.nil?
				taggings = Tagging.where(:tag_id => tag.id)
				j = 0
				shows_array = Array.new
				while j < taggings.length
					shows_array.push(taggings[j].show_id)
					j += 1
				end
				if control_character == "-"
					# if user has specified NOT, then append this onto the list of shows not to include.
					not_shows_array = not_shows_array | shows_array
				elsif control_character == "~"
					# otherwise if it's OR, append onto the list of shows.
					final_shows_array = final_shows_array | shows_array
				else
					all_shows_array.push(shows_array)
				end
			end
			# TODO: get shows which have titles like this tag name.
		end
		if not_shows_array.length > 0 and final_shows_array.length == 0 and all_shows_array.length == 0
			# there are negative tags and no positive tags in this tag search. set the base search field to be all tags.
			final_shows_array = Show.all.collect{|show| show.id}
		end
		
		# intersect each of the lists in the ALL array.
		i = 0
		while i < all_shows_array.length
			if final_shows_array.length == 0
				final_shows_array = [all_shows_array[i]]
			else
				final_shows_array = final_shows_array & all_shows_array[i]
			end
			i += 1
		end
		
		# exclude any of the shows in the NOT array.
		final_shows_array = final_shows_array - not_shows_array
		
		# now get information for each of these shows.
		# @shows = Show.find_all(final_shows_array, :order => "`upvotes` DESC, `downvotes` ASC")
		i = 0
		while i < final_shows_array.length
			@shows.push(final_shows_array[i])
			i += 1
		end
		# sort and paginate.
		@shows = Show.where(:id => @shows).order('upvotes DESC, downvotes ASC').paginate(:page => params[:page])
		# @shows.sort! { |a,b| a.upvotes == b.upvotes ? a.downvotes <=> b.downvotes : b.upvotes <=> a.upvotes }
		# @shows = @shows.paginate(:page => params[:page])		
	end

	# now get the most-frequently used tags in this group of shows.
	@popularTags = Hash.new(0)
	relevantTaggings = Tagging.count(:select => '`tag_id` AS `tagid`, COUNT(*) AS `numTaggings`', :conditions=>['show_id IN (?)', @shows], :group=>'tag_id', :limit=>25, :order=>"COUNT(*) DESC")
	relevantTaggings.each{|tagging| @popularTags[tagging[0]] = tagging[1]}
	#relevantTaggings = Tagging.select("`tag_id`, COUNT(*) as numTaggings").where(:show_id => @shows).group("`tag_id`").order("numTaggings DESC").limit(25)

	@title = "Shows"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shows }
    end
  end

  # Displays a show's information.
  # Can be accessed by GETting /shows/1 or  /shows/1.xml
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

  # Displays the form to add a new show.
  # Can be accessed by GETting /shows/new or  /shows/new.xml
  def new
    @show = Show.new
	@title = "New show"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @show }
    end
  end

  # Displays the form to edit a show's information.
  # Can be accessed by GETting /shows/edit/1
  def edit
    @show = Show.find(params[:id])
	@title = "Editing " + @show.name
  end

  # Creates a show.
  # Can be accessed by POSTING /shows or  /shows.xml
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

  # Updates a show with new information.
  # Can be accessed by PUTting /shows/1 or  /shows/1.xml
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

  # Deletes a show.
  # Can be accessed by DELETEing /shows/1 or  /shows/1.xml
  def destroy
    @show = Show.find(params[:id])
	
	# first, destroy any comments or taggings belonging to this show.	
	Comment.destroy_all(:show_id => @show.id)
	Tagging.destroy_all(:show_id => @show.id)
	
	# now destroy the show itself.
    @show.destroy

    respond_to do |format|
      format.html { redirect_to(shows_url) }
      format.xml  { head :ok }
    end
  end
  private
    def authenticate
      deny_access unless signed_in?
    end
end
