class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => "You are not allowed to perform #{exception.action.nil? ? 'this action' : exception.action} on #{exception.subject.name.nil? ? exception.subject.class.name : exception.subject.name}."
  end
end
