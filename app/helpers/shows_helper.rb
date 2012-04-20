module ShowsHelper

	# Returns the image associated with this show.
	def show_image(show = @show)
		if show.name.nil?
			image_tag("shows/blank.png", :alt => "", :class => 'show_image')
		else
			image_tag show.image.url(:medium), :alt => "#{show.name}", :class => 'show_image'
		end
	end
	
	# Returns the image thumbnail associated with this show.
	def show_image_thumb(show = @show)
		if show.name.nil?
			image_tag("shows/blank_thumb.png", :alt => "", :class => 'show_image_thumb')
		else
			image_tag show.image.url(:thumb), :alt => "#{show.name}", :class => 'show_image_thumb'
		end
	end
	
	# Displays the first n characters of a show's description (or the whole thing, if it's <= n characters long).
	def show_description_short(show = @show)
		if show.description.to_s.length > 500
			simple_format(show.description.to_s[0,500] + "...")
		else
			simple_format(show.description.to_s)
		end
	end
	
	# Returns a dropdown list of all shows in the database, selecting the relevant one (if provided).
	def show_dropdown
		collection_select(:tagging, :show_id, Show.all, :id, :name, :prompt => true)
	end
	def show_tag_sidebar_helper(tag_id, post_count)
		tag = Tag.find(tag_id)
		tag_name = tag.name
		type_name = Tagtype.find(tag.tagtype_id).name

		html = %{<li class="tag-type-#{u(type_name)}">}

		html << %{<a href="/shows?tags=#{u(tag_name)}+#{u(params[:tags])}">+</a> }
		html << %{<a href="/shows?tags=-#{u(tag_name)}+#{u(params[:tags])}">&ndash;</a> }
		html << %{<a href="/tags/#{u(tag_id)}">?</a> }
#		html << %{<a href="/shows?tags=#{u(tag_name)}+#{u(params[:tags])}">#{tag_name.tr("_", " ")}</a>}
		html << %{<a href="/shows?tags=#{u(tag_name)}">#{tag_name.tr("_", " ")}</a>}
		html << %{<span class="shows-count">#{post_count}</span>}
		html << '</li>'
		return html.html_safe
	end
  
  def show_tag_sidebar(tags)
    html = ['<div style="margin-bottom: 1em;">', '<ul id="tag-sidebar">']

	tags.each do |tag, count|
		html << show_tag_sidebar_helper(tag, count)
	end
    
    html += ['</ul>', '</div>']
    html.join("\n").html_safe
  end
end
