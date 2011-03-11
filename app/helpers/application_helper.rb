module ApplicationHelper
	# Return a title on a per-page basis.
	def title
		base_title = "LL Animu Recommendations"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end

	def logo
		image_tag("logo.png", :alt => "LL Animu Recommendations", :class => "logo")
	end
	
	def like_image
		image_tag("like.png", :alt => "Like", :class => "like")
	end

	def dislike_image
		image_tag("dislike.png", :alt => "Disike", :class => "dislike")
	end

	# Returns the image associated with this show.
	def show_image
		if @show.name.nil?
			image_tag("shows/blank.png", :alt => "")
		else
			image_tag @show.image.url(:medium), :alt => "#{@show.name}"
#			image_tag("shows/#{@show.id}.png", :alt => "#{@show.name}");
		end
	end
	
	# Returns the image thumbnail associated with this show.
	def show_image_thumb
		if @show.name.nil?
			image_tag("shows/blank_thumb.png", :alt => "")
		else
			image_tag @show.image.url(:thumb), :alt => "#{@show.name}"
#			image_tag("shows/#{@show.id}_thumb.png", :alt => "#{@show.name}");
		end
	end
	
	# Displays the first 50 characters of a show's description (or the whole thing, if it's <= 50 characters long).
	def show_description_short
		if @show.description.to_s.length > 50
			@show.description.to_s.split('').first(50).to_s + "..."
		else
			@show.description.to_s
		end
	end
	
	# Returns a dropdown list of all shows in the database, selecting the relevant one (if provided).
	def show_dropdown
		collection_select(:tagging, :show_id, Show.all, :id, :name, :prompt => true)
	end
	
	# Returns a dropdown list of all tags in the database, selecting the relevant one (if provided).
	def tag_dropdown
		collection_select(:tagging, :tag_id, Tag.all, :id, :name, :prompt => true)
	end

	# Returns a table-formatted tag cloud of tags associated with this show.
	def tag_cloud
		output_string = ""
		unless @show.taggeds.empty?
			@show.taggeds = @show.taggeds.sort_by(&:name)
			@show.taggeds.each do |tag|
				if output_string.blank?
					output_string = link_to(tag.name, tag, :title => tag.description)
				else
					output_string = "#{output_string}, " + link_to(tag.name, tag, :title => tag.description)
				end
			end
		else
			output_string = "There are no tags attached to this anime yet."
		end
		output_string = output_string + " " + link_to("(Add a tag)", new_tagging_path(:show_id => @show.id))
		raw output_string
	end
end