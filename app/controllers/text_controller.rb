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

		transcript = item.transcription(source: source)
		@title = item.title
		@fs = item.fs

		@transform = transcript.transform_main_view



	end
end
