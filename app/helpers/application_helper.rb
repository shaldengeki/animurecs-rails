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
end