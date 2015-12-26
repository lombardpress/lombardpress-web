class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  
  protect_from_forgery with: :exception
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale
  
  before_filter :set_conf, :check_for_user

  # I wish I could do this in a policy but currently can't figure out how
  

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  private
    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || permissions_path)
    end
    def set_conf
      if Rails.env.development?
        # only needed for developement
        port = request.port
        if port + 1 == 3009 
          cid = port.to_s.split('').last().to_i + 1
        elsif port + 1 >= 3010
          cid = port.to_s.split('').last(2).join.to_i + 1
        else
          cid = port.to_s.split('').last.to_i + 1
        end
        commentaryid = Setting.find(cid).commentaryid
      elsif request.host == "petrusplaoul.org" || request.host == "www.petrusplaoul.org" 
        commentaryid = "plaoulcommentary"
      elsif request.host == "adamwodeham.org" || request.host == "www.adamwodeham.org"
        commentaryid = "wodehamordinatio"  
      elsif request.subdomains.any?
        commentaryid = request.subdomains.first
      end
      #@config = LbpConfig.new(url)
      @config = Setting.find_by(commentaryid: commentaryid)
      Rails.application.config.action_mailer.default_url_options[:host] = request.host
    end
    def check_for_user
      unless request.path == "/users/sign_in" or request.path == "/users/password/new" or request.path == "/users/password" or request.path == "/users/password/edit"
        if current_user.nil?
          redirect_to "/users/sign_in", :alert => "This site is currently in alpha development. It is currently accessible by invitation only."
        end
      end
    end
end
