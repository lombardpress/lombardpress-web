class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  
  

  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_filter :set_conf
  

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || permissions_path)
  end
  def set_conf
    host = request.host_with_port
    @config = LbpConfig.new(host)
  end
end
