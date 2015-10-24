class SettingsController < ApplicationController
	before_filter :authenticate_user!

	def index
		@settings = Setting.all
		#binding.pry @settings
    authorize @settings
	end
	def show
		if params[:id] == "current"
			@setting = Setting.find_by(commentaryid: @config.commentaryid)
		else
			@setting = Setting.find(params[:id])
		end
		authorize @setting
	end
	def edit
		
 		@setting = Setting.find(params[:id])
		authorize @setting
	end
	def update
		@setting = Setting.find(params[:id])
		authorize @setting
		if @setting.update(setting_params)
			redirect_to settings_path, :notice => "Setting successfully updated"
		else
			render 'edit'
		end

	end
	
	private 
		
		def setting_params
	  	
	  	
	  	
	  	#here I'm making sure these value get set as booleans.
	  	params[:setting][:blog] = to_boolean(params[:setting][:blog])
	  	params[:setting][:images] = to_boolean(params[:setting][:images])
	  	params[:setting][:properties] = eval(params[:setting][:properties])
	  
	  	params.require(:setting).permit!
	  end
		
		# a simple function to return a "true" "false" string as a boolean value
		
		def to_boolean(str)
		  str.downcase == 'true'
		end

end
