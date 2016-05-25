class TextController < ApplicationController
	include TextMethods
	
	#TODO this make question list the index page
	# current division between index and question list is confusing
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
		
		if params[:resourceid] != nil
			resource = Lbp::Resource.new("http://scta.info/resource/#{params[:resourceid]}")
			# TODO this first conditional should be chanted to 
			# if resource is topLevelWorkGroup
			if resource.resource_shortId == "scta"
				@results = WorkGroupQuery.new.work_group_list(params[:resourceid])
				render "workgrouplist"
			elsif resource.type_shortId == "workGroup"
				@results = WorkGroupQuery.new.expression_list(params[:resourceid])
				render "expressionlist"
				# a conditional like this could display expression types
					#elsif resource.type == "http://scta.info/resource/lectio"
						#	puts "test"
				# another conditional could handle a list for an author
					#elsif resource.type == "http://scta.info/resource/person"
						#	puts "test"
				elsif params[:resourceid]
					expressionid = params[:resourceid]
					url =  "<http://scta.info/resource/#{expressionid}>" 
					@results = Lbp::Query.new().collection_query(url)
				end
			else
				if @config.commentaryid == "scta"
					@results = WorkGroupQuery.new.work_group_list(@config.commentaryid)
					render "workgrouplist"
				else
					commentaryid = @config.commentaryid
					url =  "<http://scta.info/resource/#{commentaryid}>"
					@results = Lbp::Query.new().collection_query(url)
				end
			end
		end

	def info
		expression = get_expression(params)
		check_permission(expression)
		@title = expression.title
		#@itemid should be equivalent to expression id
		@itemid = params[:itemid]
		url_short_id = get_shortid(params)
		
		url = "http://scta.info/resource/#{url_short_id}"
		query = Lbp::Query.new
		@name_results = query.names(url)
		@quote_results = query.quotes(url)
		
	end

	def status
		#commentaryid = @config.commentaryid
		url = "<http://scta.info/resource/#{params[:itemid]}>"
		results = Lbp::Query.new.item_query(url)

		# @itemid is equivalent to @expression id
		# will be changed as part of global change 
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
		
		# get expression and related info
		@expression = get_expression(params)
		
		@expression_structure = @expression.structureType_shortId
		# perform checks
		check_transcript_existence(@expression)
		check_permission(@expression); return if performed?
		
		if @expression.status == "In Progress" || @expression.status == "draft"
			flash.now[:alert] = "Please remember: the status of this text is draft. You have been granted access through the generosity of the editor. Please use the comments to help make suggestions or corrections."
		end
		
		#get values  needed for view
		#@expressionid = params[:itemid]
		@title = @expression.title
		@next_expressionid = if @expression.next != nil then @expression.next.split("/").last else nil end
		@previous_expressionid = if @expression.previous != nil then @expression.previous.split("/").last else nil end

		#get transcription Object from params	
		transcript = get_transcript(params)
		
		

		# ms_slugs is not great because its hard coding "critical"
    # what if the name of the manifestion for a critical manifestion was not called critical
    # more idea to check database to get a manifestationType
    # but this could be costly. If there were 20 or 30 manifestations 
    # then you'd be making lots of requests to db
    # this map is reused in the paragraph controller as well; should be refactored
    ms_slugs = @expression.manifestationUrls.map {|m| unless m.include? 'critical' then m.split("/").last end}.compact
		default_wit_param = ms_slugs[0]

		#prepare xslt arrays to be used for transformation
			#always remember single quotes for paramater value
			#specify if global image setting is true or false
		
			
		xslt_param_array = ["default-ms-image", if default_wit(params) == "critical" then "'#{default_wit_param}'" else "'#{default_wit(params)}'" end, 
				"default-msslug", "'#{default_wit(params)}'", 
				"show-images", "'#{@config.images.to_s}'",
				"by_phrase", "'#{t(:by)}'", 
				"edited_by_phrase", "'#{t(:edited_by)}'"]
		
		# get file object to be tansformed
		# and perform transformation
		if @expression_structure == "structureItem"
			file = transcript.file(@config.confighash)
			@transform = file.transform_main_view(xslt_param_array)
		elsif @expression_structure == "structureBlock"
			file = transcript.file_part(@config.confighash, params[:itemid])
			@transform = file.transform_plain_text(xslt_param_array)
		end
	end
	
	def xml
		expression = get_expression(params)
		@expression_structure = expression.structureType_shortId
		
		check_permission(expression)
		
		transcript = get_transcript(params)

		if @expression_structure == "structureItem"
			file = transcript.file(@config.confighash)
			@nokogiri = file.nokogiri
		elsif @expression_structure == "structureBlock"
			# NOTE: don't be confused by item id here; it is the id of the block express
			# all :itemid should be interpreted as shortId of the expression.
			# the will eventually all be changed to "expressionid"
			file = transcript.file_part(@config.confighash, params[:itemid])
			@nokogiri = file.xml
		end
	end

	def toc 
		expression = get_expression(params)
		@expression_structure = expression.structureType_shortId
		
		check_permission(expression)

		transcript = get_transcript(params)

		if @expression_structure == "structureItem"
			file = transcript.file(@config.confighash)
		elsif @expression_structure == "structureDivision"
			## until each structure division has its own 
			## tei file, it will need to use the file_part class
			## and will need a method that can get the toc of just that part
		end
		@toc = file.transform_toc
		render :layout => false
	end

	def draft_permissions
		
	end

	private

end
