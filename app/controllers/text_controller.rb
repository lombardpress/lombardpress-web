class TextController < ApplicationController
	include TextMethods
	
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
		
		check_transcript_existence(item, params); return if performed?
		
		@title = item.title
		#remove @fs after check for use. use itemid instead
		@fs = item.fs
		@itemid = item.fs
		@next_itemid = item.next.split("/").last
		@previous_itemid = item.previous.split("/").last
		transcript = get_transcript(item, params)
		
		#always remember single quotes for paramater value
		xslt_param_array = ["default-ms-image", if default_wit(params) == "critical" then @config.default_ms_image else "'#{default_wit(params)}'" end, "default-msslug", "'#{default_wit(params)}'"]
		@transform = transcript.transform_main_view(xslt_param_array)

	end
	
	def xml
		item = get_item(params)
		check_permission(item)

		transcript = get_transcript(item, params)
		@nokogiri = transcript.nokogiri
	end

	def toc 
		item = get_item(params)
		check_permission(item)

		transcript = get_transcript(item, params)
		@toc = transcript.transform_toc
		render :layout => false
	end

	private

end
