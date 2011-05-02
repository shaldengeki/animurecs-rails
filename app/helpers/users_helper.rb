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
end
