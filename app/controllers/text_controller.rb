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

	def info
		item = get_item(params)
		
		check_permission(item)

		


		@title = item.title
		@itemid = item.fs
		commentaryid = @config.commentaryid
		url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"
		query = Lbp::Query.new
		@name_results = query.names(url)
		@quote_results = query.quotes(url)
		

		

	end

	def status
		commentaryid = @config.commentaryid
		url = "<http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}>"
		results = Lbp::Query.new.item_query(url)
		@itemid = params[:itemid]
		@results = results.order_by(:transcript_type)
	end

	def show
		
		item = get_item(params)
		
		check_permission(item); return if performed?
		# need to fix database to include critical transcript as object of hasTranscription
		# then uncomment below

		# I don't quite understand the return if performed - got things to work following this http://blog.arkency.com/2014/07/4-ways-to-early-return-from-a-rails-controller/								
		check_transcript_existence(item, params); return if performed?
		

		
		

		@title = item.title
		#remove @fs after check for use. use itemid instead
		@fs = item.fs
		@itemid = item.fs
		@next_itemid = item.next.split("/").last
		@previous_itemid = item.previous.split("/").last
		
		transcript = get_transcript(item, params)
		xslt_param_array = ["default-ms-image", @config.default_ms_image]
		@transform = transcript.transform_main_view(xslt_param_array)

	end
	
	def xml
		item = get_item(params)
		check_permission(item)

		transcript = get_transcript(item, params)
		@nokogiri = transcript.nokogiri
	end

	private
	def get_item(params)
			config_hash = @config.confighash
			commentaryid = @config.commentaryid
			url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"
			item = Lbp::Item.new(config_hash, url)
		end

		def check_permission(item)
			if item.status == "In Progress" || item.status == "draft"
				if current_user.nil?
					redirect_to "/permissions#draftview", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
				elsif current_user.draft_reader? || current_user.draft_img_reader?
					allowed_texts = current_user.texts.map {|text| text.itemid}
					unless allowed_texts.include? params[:itemid]
						redirect_to "/permissions#draftview", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
					end

				elsif !current_user.admin? 
					redirect_to "/permissions#draftview", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
				end
			end
		end

		def get_transcript(item, params, source="origin")
			wit = if params.has_key?(:msslug) then params[:msslug] else "critical" end
			transcript = item.transcription(source: source, wit: wit)
		end
		def check_transcript_existence(item, params)
			wit = if params.has_key?(:msslug) then params[:msslug] else "critical" end
				unless item.transcription?(wit)
					redirect_to "/text/status/#{params[:itemid]}", :alert => "A critical/normalized edition of this text does not exist yet. Below are the available transcriptions." and return
			end
		end
end
