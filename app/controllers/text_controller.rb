class TextController < ApplicationController
	
  
  def index
  		commentaryid = @config.commentaryid
			url =  "<http://scta.info/text/#{commentaryid}/commentary>" 
			@results = Lbp::Query.new().collection_query(url)
	end
	def questions
			commentaryid = @config.commentaryid
			url =  "<http://scta.info/text/#{commentaryid}/commentary>" 
			@results = Lbp::Query.new().collection_query(url)
	end

	def show

# use query on item here to check status
# if it has a critical transcription go directly there
# if it does not give, offer message then choices to existing transcription
		config_hash = @config.confighash
		commentaryid = @config.commentaryid
		url = "http://scta.info/text/#{commentaryid}/item/#{params[:id]}"
		item = Lbp::Item.new(config_hash, url)
		
		if item.status == "In Progress" || item.status == "draft"
			if current_user.nil?
				redirect_to "/permissions#draftview", :alert => "Access denied: This text is a draft. It requires permission to be viewed."
			elsif !current_user.admin? 
				redirect_to "/permissions#draftview", :alert => "Access denied: This text is a draft. It requires permission to be viewed."
			end
		end

		source = "origin"
		if params.has_key?(:msslug)
			wit = params[:msslug]
		else
			wit = "critical"
		end
		transcript = item.transcription(source: source, wit: wit)
		@title = item.title
		@fs = item.fs
		
		xslt_param_array = ["default-ms-image", @config.default_ms_image]
		@next_itemid = item.next.split("/").last
		@previous_itemid = item.previous.split("/").last
		
		@transform = transcript.transform_main_view(xslt_param_array)



	end
end
