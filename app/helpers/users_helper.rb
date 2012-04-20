module UsersHelper
	def avatar_image(user = @user)
		if user.username.nil?
			image_tag("users/blank.png", :alt => "", :class => 'avatar')
		else
			image_tag user.avatar.url(:medium), :alt => "#{user.username}", :class => 'avatar'
		end
	end
	def avatar_image_thumb(user = @user)
		if user.username.nil?
			image_tag("users/blank.png", :alt => "", :class => 'avatar_thumb')
		else
			image_tag user.avatar.url(:thumb), :alt => "#{user.username}", :class => 'avatar_thumb'
		end
	end
	def user_header_profile_pic(user = @current_user)
		if user.nil? or user.username.nil?
			image_tag("users/blank.png", :alt => "", :class => 'avatar_thumb')
		else
			image_tag user.avatar.url(:tiny), :alt => "#{user.username}", :class => 'user_header_profile_pic'
		end
	end
  def user_notifications_div(user=@current_user)
    if user.nil? or user.username.nil?
      raw "<div>0</div>"
    else
      raw "<div>0</div>"
    end
  end
end
