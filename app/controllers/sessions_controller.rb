class SessionsController < ApplicationController
  # Displays sign in page.
  def new
    @title = "Sign in"
  end

  # Creates a new user session.
  def create
    user = User.authenticate(params[:session][:username],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid username/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end

  # Destroys a user session.
  def destroy
    sign_out
    redirect_to root_path
  end
end
