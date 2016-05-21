class TextController < ApplicationController
	include TextMethods
	
  def index
		commentaryid = @config.commentaryid
		url =  "<http://scta.info/text/#{commentaryid}/commentary>" 
		@results = Lbp::Query.new().collection_query(url)
	end
	def questions
		# commentarydirname should be changed to resource type
		# it would be even more ideal if this information could be grabbed from the database
		# get type of resource and then adjust the query to the kind of resource this is.
		
		# TODO create method in lbp.rb to check recourse of any short id
		# re-write conditional based on these values
		# conditional should simply ask: is this a work group, a work, or an expression or even an author
		# controller should route to the appropriate view based on the resource type. 
		# for example if it is an author we should list all expressions by this author
		# if it is a an expresion it should list all expressions parts with structure type=item
		# if it is a work, it should list available expression if there are more than one, 
		# otherwise, if there is only expression, it should re-route to the top-level expression view.

		if params[:resourceid] == "sententia" || params[:resourceid] == "deanima"
			@results = WorkGroupQuery.new.expression_list(params[:resourceid])
			render "expressionlist"
		elsif params[:resourceid]
			expressionid = params[:resourceid]
			url =  "<http://scta.info/resource/#{expressionid}>" 

			@results = Lbp::Query.new().collection_query(url)
		else
			if @config.commentarydirname == "workgroup" 
				@results = WorkGroupQuery.new.expression_list(@config.commentaryid)
				render "expressionlist"
			else
				commentaryid = @config.commentaryid
				url =  "<http://scta.info/resource/#{commentaryid}>"
				@results = Lbp::Query.new().collection_query(url)
			end
		end
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
		if @results.count == 0
			flash.clear
		end
	end

	def show
		if params.has_key?(:search)
			flash.now[:notice] = "Search results for instances of #{params[:searchid]} (#{params[:search]}) are highlighted in yellow below." 
		end
		
		item = get_item(params)
		check_permission(item); return if performed?
		
		#check_transcript_existence(item, params); return if performed?

		if item.status == "In Progress" || item.status == "draft"
			flash.now[:alert] = "Please remember: the status of this text is draft. You have been granted access through the generosity of the editor. Please use the comments to help make suggestions or corrections."
		end
		
		@title = item.title

		#remove @fs after check for use. use itemid instead
		#@fs = item.fs
		#@itemid = item.fs
		
		@next_itemid = if item.next != nil then item.next.split("/").last else nil end
		@previous_itemid = if item.previous != nil then item.previous.split("/").last else nil end

		transcript = get_transcript(item, params)
		
		#always remember single quotes for paramater value
		#specify if global image setting is true or false
		xslt_param_array = ["default-ms-image", if default_wit(params) == "critical" then @config.default_ms_image else "'#{default_wit(params)}'" end, 
				"default-msslug", "'#{default_wit(params)}'", 
				"show-images", "'#{@config.images.to_s}'",
				"by_phrase", "'#{t(:by)}'", 
				"edited_by_phrase", "'#{t(:edited_by)}'"]
		
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
