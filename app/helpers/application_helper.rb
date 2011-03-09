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

	# Returns the image associated with this series.
	def series_image
		if @series.name.nil?
			image_tag("series/blank.png", alt => "")
		else
			image_tag("series/#{@series.name}.png", alt => "#{@series.name}");
		end
	end
end