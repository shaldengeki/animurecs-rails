module TagsHelper
	# Returns a dropdown list of all tags in the database, selecting the relevant one (if provided).
	def tags_dropdown
		collection_select(:tagging, :tag_id, Tag.all, :id, :name, :prompt => true)
	end

	# replaces underscores in a tag name with spaces.
	def tag_name_replaced(tag)
		if tag.name.nil?
			""
		else
			tag.name.gsub(/_/, ' ')
		end
	end
	
	# formats a tagname for output as a link.
	def prettify_tag_link(tag)
		if tag.name.nil?
			""
		else
#			%{<a href="/shows?tags=#{u(tag.name)}+#{u(params[:tags])}" title="#{u(tag.description)}" style="color:\##{@tagtypes.find{|tagtype| tagtype.id == tag.tagtype_id}.color};">#{tag.name.tr("_", " ")}</a>}
			link_to(tag.name.gsub(/_/, ' '), tag, {:title => tag.description, :style=>'color:#'+@tagtypes.find{|tagtype| tagtype.id == tag.tagtype_id}.color+';'})
		end
	end

	# looks up a tag to see if it's in memory. if it's not, adds it to memory and returns the tag.
	# if it is, just returns the tag in memory.
	def find_tag(tag_id)
		if @tags[tag_id.to_s].nil?
			@tags[tag_id.to_s] = Tag.find(tag_id.to_s)
		end
		@tags[tag_id.to_s]
	end
	
	# formats a tag for output as a link, taking a tagging as an input.
	def prettify_tagging_link(tagging)
		if tagging.tag_id.nil?
			""
		else
			tag = find_tag(tagging.tag_id)
			tagtype = @tagtypes.find{|tagtype| tagtype.id == tag.tagtype_id}
#			%{<a href="/shows?tags=#{u(tag.name)}+#{u(params[:tags])}" title="#{u(tag.description)}" style="color:\##{@tagtypes.find{|tagtype| tagtype.id == tag.tagtype_id}.color};">#{tag.name.tr("_", " ")}</a>}
			output_string = link_to(tag.name.gsub(/_/, ' '), tag, {:title => tag.description, :class=>'tag-type-'+tagtype.name})
			if signed_in?
				output_string + link_to('(x)', tagging, :confirm => 'Are you sure?', :method => :delete, :class => 'delete-tagging')
			else
				output_string
			end
		end
	end

	def prettify_tag_title(tag)
		if tag.name.nil?
			"None"
		else
			link_to(Tagtype.find(tag.tagtype).name + ":" + tag.name.gsub(/_/, ' '), tag, {:title => tag.description, :style=>'color:#'+@tagtypes.find{|tagtype| tagtype.id == tag.tagtype_id}.color+';'})
		end
	end

	# Displays the first n characters of a show's description (or the whole thing, if it's <= n characters long).
	def tag_description_short(tag = @tag)
		if tag.description.to_s.length > 50
			tag.description[0,50] + "..."
		else
			tag.description.to_s
		end
	end
	
	# Returns a table-formatted tag cloud of tags associated with this show.
	def tag_cloud(show, limit=0)
		output_string = ""
		if limit != 0
			show_taggings = Tagging.where(:show_id => show.id).limit(limit)
		else
			show_taggings = Tagging.where(:show_id => show.id)
		end
		unless show_taggings.empty?
			# show_taggings.each{|tagging| show_tags.push(Tag.find(tagging.tag_id))}
			# show_tags = show_tags.sort_by(&:name)
			# show.taggeds = show.taggeds.sort_by(&:name)
			# show.taggeds.each do |tag|
			# show_tags.each do |tag|
				# if output_string.blank?
					# output_string = prettify_tag_link(tag)
				# else
					# output_string = "#{output_string}, " + prettify_tag_link(tag)
				# end
			# end
			tagging_link_list = Hash.new()
			show_taggings.each do |tagging|
				tagging_link_list[find_tag(tagging.tag_id).name] = prettify_tagging_link(tagging)
#				if output_string == ""
#					output_string = prettify_tagging_link(tagging)
#				else
#					output_string = "#{output_string}, " + prettify_tagging_link(tagging)
#				end
			end
			tagging_link_list.keys.sort.each do |key|
				if output_string == ""
					output_string = tagging_link_list[key]
				else
					output_string = output_string + " " + tagging_link_list[key]
				end
			end
		else
			output_string = "None"
		end
		output_string = output_string + " " + link_to("(Add a tag)", new_tagging_path(:show_id => show.id))
		raw output_string
	end
end
