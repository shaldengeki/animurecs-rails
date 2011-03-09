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

	# Returns the image associated with this show.
	def show_image
		if @show.name.nil?
			image_tag("shows/blank.png", :alt => "")
		else
			image_tag("shows/#{@show.name}.png", :alt => "#{@show.name}");
		end
	end
end