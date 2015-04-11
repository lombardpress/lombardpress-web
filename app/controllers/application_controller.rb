class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  
  

  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :set_conf, :check_for_user

  # I wish I could do this in a policy but currently can't figure out how
  


  

  private
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || permissions_path)
  end
  def set_conf
    url = request.url
    @config = LbpConfig.new(url)
    Rails.application.config.action_mailer.default_url_options[:host] = request.subdomain + request.host
  end
  def check_for_user
    unless request.path == "/users/sign_in" or request.path == "/users/password/new" or request.path == "/users/password" or request.path == "/users/password/edit"
      if current_user.nil?
        redirect_to "/users/sign_in", :alert => "This site is currently in alpha development. It is currently accessible by invitation only."
      end
  end
  end
end
