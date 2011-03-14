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
			link_to(tag.name.gsub(/_/, ' '), tag, {:title => tag.description, :style=>'color:#'+Tagtype.find(tag.tagtype).color+';'})
		end
	end

	def prettify_tag_title(tag)
		if tag.name.nil?
			"None"
		else
			link_to(Tagtype.find(tag.tagtype).name + ":" + tag.name.gsub(/_/, ' '), tag, {:title => tag.description, :style=>'color:#'+Tagtype.find(tag.tagtype).color+';'})
		end
	end

	# Displays the first n characters of a show's description (or the whole thing, if it's <= n characters long).
	def tag_description_short(tag = @tag)
		if tag.description.to_s.length > 50
			tag.description.to_s.split('').first(50).to_s + "..."
		else
			tag.description.to_s
		end
	end
	
	# Returns a table-formatted tag cloud of tags associated with this show.
	def tag_cloud(show)
		output_string = ""
		unless show.taggeds.empty?
			show.taggeds = show.taggeds.sort_by(&:name)
			show.taggeds.each do |tag|
				if output_string.blank?
					output_string = prettify_tag_link(tag)
				else
					output_string = "#{output_string}, " + prettify_tag_link(tag)
				end
			end
		else
			output_string = "None"
		end
		output_string = output_string + " " + link_to("(Add a tag)", new_tagging_path(:show_id => show.id))
		raw output_string
	end
end
