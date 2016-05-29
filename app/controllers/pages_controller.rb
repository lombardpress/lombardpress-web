class PagesController < ApplicationController
	
	
	def home
		if @config.commentaryid != "scta" 
			redirect_to "/text/questions/#{@config.commentaryid}" 
				#if @config == nil
		#	@commentaries = Setting.all
		#	render :home_global, layout: false
		else
			render :home
		end
	end
	
	def permissions
		
	end

	
	
end
