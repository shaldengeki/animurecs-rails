module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
  end
  def signed_in?
    !current_user.nil?
  end
  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  def current_user=(user)
    @current_user = user
  end
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  def admin_user?
    (!current_user.nil? && current_user.userlevel > 1)
  end
  def moderator_user?
    (!current_user.nil? && current_user.userlevel > 0)
  end
  def current_user?(user)
    user == current_user
  end
  def deny_access
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  def return_to_addr
    session[:return_to]
  end
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  def user_type(user)
		case user.userlevel
		when 0
			"Normal"
		when 1
			"Moderator"
		when 2
			"Administrator"
		else
			"Unknown"
		end
  end

  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    def store_location
      session[:return_to] = request.fullpath
    end
    def clear_return_to
      session[:return_to] = nil
    end

end
