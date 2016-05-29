class PagesController < ApplicationController
	
	
	def home

		if request.host.include? "petrusplaoul"
          redirect_to "/text/questions/plaoulcommentary"
    elsif request.host.include? "adamwodeham"
      redirect_to "/text/questions/wodehamordinatio"
    elsif request.subdomains.any?
    	redirect_to "/text/questions/#{request.subdomains.first}" 
    else
			render :home
		end
	end
	
	def permissions
		
	end

	
	
end
