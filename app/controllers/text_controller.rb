class TextController < ApplicationController
  def index
  		
			url =  "<http://scta.info/text/#{$commentaryid}/commentary>" 
			@results = query_obj = Lbp::Query.new().collection_query(url)
			
	end

	def show

# use query on item here to check status
# if it has a critical transcription go directly there
# if it does not give, offer message then choices to existing transcription
		config_hash = Rails.application.config.confighash
		commentaryid = Rails.application.config.commentaryid
		url = "http://scta.info/text/#{commentaryid}/item/#{params[:id]}"
		
		item = Lbp::Item.new(config_hash, url)
		source = "origin"
		if params.has_key?(:msslug)
			wit = params[:msslug]
		else
			wit = "critical"
		end
		transcript = item.transcription(source: source, wit: wit)
		@title = item.title
		@fs = item.fs
		
		xslt_param_array = ["default-ms-image", Rails.application.config.default_ms_image]
		@transform = transcript.transform_main_view(xslt_param_array)



	end
end
