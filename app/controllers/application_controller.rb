class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # before_filter :configure_permitted_parameters, if: :devise_controller?
  skip_before_filter  :verify_authenticity_token
  # protect_from_forgery with: :exception
  # include SessionsHelper
  # protected
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :name 
  # end
end
