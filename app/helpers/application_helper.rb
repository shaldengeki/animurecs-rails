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
	
	# Returns a table-formatted tag cloud of tags associated with this show.
	def tag_cloud
		output_string = ""
		unless @show.taggeds.empty?
#			output_string = output_string + "<table class='tagcloud' summary='Show Tag Cloud'>
#	<tr>
#"
#			i = 0
			@show.taggeds.each do |tag|
				if output_string.blank?
					output_string = tag.name
				else
					output_string = "#{output_string}, #{tag.name}"
				end
#				output_string = output_string + '		<td>' + tag.name + '</td>
#'
#				if (i > 4)
#					output_string = output_string + '	</tr>
#'
#					i = 1
#				end
			end
#			output_string = output_string + '	</tr>
#  </table>'
		else
			output_string = "There are no tags attached to this anime yet."
		end
		output_string
	end
end