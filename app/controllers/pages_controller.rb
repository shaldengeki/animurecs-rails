class PagesController < ApplicationController
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