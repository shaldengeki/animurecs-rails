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
  
  def display_show_like_button(show)
    output_html = "<span class = 'like_button'>"
    if signed_in? 
      output_html = output_html + link_to(like_image + " " + show.upvotes.to_s + " likes", {:controller => :showvotes, :action => :create, :vote_val => 1, :show_id => show.id, :user_id => @current_user.id}, :method => :create, :remote => true, :class => 'upvote_show')
    else 
      output_html = output_html + like_image + " " + show.upvotes.to_s + " likes"
    end
    output_html + "</span>"
  end  
  def display_show_dislike_button(show)
    output_html = "<span class = 'dislike_button'>"
    if signed_in? 
      output_html = output_html + link_to(dislike_image + " " + show.downvotes.to_s + " dislikes", {:controller => :showvotes, :action => :create, :vote_val => -1, :show_id => show.id, :user_id => @current_user.id}, :method => :create, :remote => true, :class => 'downvote_show')
    else 
      output_html = output_html + dislike_image + " " + show.downvotes.to_s + " dislikes"
    end
    output_html + "</span>"    
  end
end