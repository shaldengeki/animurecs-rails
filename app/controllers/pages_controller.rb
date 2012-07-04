class PagesController < ApplicationController
  skip_authorization_check
  def home
	# Home index page.
    @title = "Home"
  end
  
  def contact
	# Contact page.
    @title = "Contact"
  end

  def about
	# About page.
    @title = "About"
  end  
end