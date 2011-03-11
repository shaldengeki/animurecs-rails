module ShowsHelper

	# Returns the image associated with this show.
	def show_image(show = @show)
		if show.name.nil?
			image_tag("shows/blank.png", :alt => "")
		else
			image_tag show.image.url(:medium), :alt => "#{show.name}"
#			image_tag("shows/#{@show.id}.png", :alt => "#{@show.name}");
		end
	end
	
	# Returns the image thumbnail associated with this show.
	def show_image_thumb(show = @show)
		if show.name.nil?
			image_tag("shows/blank_thumb.png", :alt => "")
		else
			image_tag show.image.url(:thumb), :alt => "#{show.name}"
#			image_tag("shows/#{@show.id}_thumb.png", :alt => "#{@show.name}");
		end
	end
	
	# Displays the first 50 characters of a show's description (or the whole thing, if it's <= 50 characters long).
	def show_description_short(show = @show)
		if show.description.to_s.length > 300
			show.description.to_s.split('').first(300).to_s + "..."
		else
			show.description.to_s
		end
	end
	
	# Returns a dropdown list of all shows in the database, selecting the relevant one (if provided).
	def show_dropdown
		collection_select(:tagging, :show_id, Show.all, :id, :name, :prompt => true)
	end
end
