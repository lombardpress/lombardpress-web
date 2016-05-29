class PagesController < ApplicationController
	
	
	def home

		unless request.host.include? "scta" or request.host.include? "scta-staging"
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

	end
	
	def permissions
		
	end

	
	
end
