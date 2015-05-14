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
		if params.has_key?(:search)
			flash.now[:notice] = "Search results for instances of #{params[:searchid]} (#{params[:search]}) are highlighted in yellow below." 
		end
		
		item = get_item(params)
		check_permission(item, params); return if performed?
		check_transcript_existence(item, params); return if performed?

		if item.status == "In Progress" || item.status == "draft"
			flash.now[:alert] = "Please remember: the status of this text is draft. You have been granted access through the generosity of the editor. Please use the comments to help make suggestions or corrections."
		end
		
		@title = item.title
		#remove @fs after check for use. use itemid instead
		@fs = item.fs
		@itemid = item.fs
		@next_itemid = if item.next != nil then item.next.split("/").last else nil end
		@previous_itemid = if item.previous != nil then item.previous.split("/").last else nil end

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

	def draft_permissions
		
	end

	private

end
