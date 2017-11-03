class TextController < ApplicationController
	include TextMethods

	#TODO this make question list the index page
	# current division between index and question list is confusing
  def index
		redirect_to "/text/questions"
	end
	def questions
		if params[:resourceid] != nil
			#I'm using the full Id rather than short_id because not all resources in db have a short_id yet. this needs to be added
			#TODO review lbp resource find, and see if the request looking for resource using short id in query in necessary
			# an alternative would be to construct to the full from the short_id and then use one and the same query to get the resource properties
			if params[:resourceid].include?("http")
				@resource = Lbp::Resource.find(params[:resourceid])
			else
				@resource = Lbp::Resource.find("http://scta.info/resource/#{params[:resourceid]}")
			end

			if @resource.type.short_id == "workGroup"
				@results = @resource.parts_display
				@expression_results = @resource.expressions_display
				@info = @resource.info_display
				render "text/questions/workgrouplist"
			elsif @resource.type.short_id == "expressionType"
				@results = @resource.structure_items_by_expression_display
				@info = @resource.info_display
				@expressions = @results.map {|result| {expression: result[:expression], expressiontitle: result[:expressiontitle], authorTitle: result[:authorTitle]}}.uniq!
				render "text/questions/expressionType_expressionList"
			# TODO need an lbp class for Person
			elsif @resource.type.short_id == "person"
				@results = MiscQuery.new.author_expression_list(@resource.short_id)
				sameas = @resource.value("http://www.w3.org/2002/07/owl#sameAs")
				dbpediaAddress = sameas

				if dbpediaAddress.nil?
					result = [];
				else
					dbpediaGraph = RDF::Graph.load(dbpediaAddress)
					query = RDF::Query.new({:person =>
						{
							RDF::URI("http://dbpedia.org/ontology/abstract") => :abstract
							#RDF::URI("http://dbpedia.org/ontology/birthDate") => :birthDate
						}
						})
						result  = query.execute(dbpediaGraph)
				end

				current_language = I18n.locale
				@language_result = result.find { |solution| solution.abstract.language == current_language}
				@language_result = @language_result.nil? ? nil : @language_result[:abstract].to_s + " (Wikipedia Abstract)"
				@dob = @resource.value("http://rcs.philsem.unibas.ch/resource/birthDate")
				@pob = @resource.value("http://rcs.philsem.unibas.ch/resource/birthPlace")
				@dod = @resource.value("http://rcs.philsem.unibas.ch/resource/deathDate")
				@order = @resource.value("http://rcs.philsem.unibas.ch/resource/religiousOrder")
				@sinfo = @resource.values("http://rcs.philsem.unibas.ch/resource/sententiariusInfo")
				render "text/questions/authorlist"
			elsif params[:resourceid]
				@results = @resource.structure_items_display
				if @resource.level == 1
					@info = @resource.info_display
					@sponsors = @resource.sponsors_display(@info)
					@articles = @resource.articles_display(@info)
					@questionEditor = @resource.value("http://scta.info/property/questionListEditor")
					@questionEncoder = @resource.value("http://scta.info/property/questionListEncoder")
					render "text/questions/questions_with_about"
				else
					render "text/questions/questions"
				end
			end
		# TODO review which part if any of the conditional below is necessary
		else
			if @config.commentaryid == "scta"
				@resource = Lbp::Resource.find("http://scta.info/resource/scta")
				@results = @resource.parts_display
				@expression_results = @resource.expressions_display
				@info = @resource.info_display
				render "text/questions/workgrouplist"
			else
				commentaryid = @config.commentaryid
				@resource = Lbp::Resource.find("http://scta.info/resource/#{commentaryid}")
				@results = @resource.structure_items_display
			end
		end
	end

	def info
		# para variable here is simpy the expressionObj
    expression = get_expression(params)
    number = expression.order_number
		manifestations = order_manifestations(expression)
		expression_hash = {
        #:pid => pid,
        :itemid => params[:itemid],
				:expression_url => expression.url,
        :next => if expression.next != nil then expression.next.to_s.split("/").last else nil end,
        :previous => if expression.previous != nil then expression.previous.to_s.split("/").last else nil end,
        :number => number,
				:inbox => if expression.inbox.to_s != nil then expression.inbox.to_s else nil end,
				:is_structure_block => if expression.structure_type.short_id == "structureBlock" then true else false end,
        :manifestations => expression.manifestations.map {|m| m.to_s},
				:manifestations_structure => manifestations,
				:translations => expression.translations.map {|m| m.to_s},
        :abbreviates => expression.abbreviates.map {|item| item.to_s},
        :abbreviatedBy => expression.abbreviatedBy.map {|item| item.to_s},
        :references => expression.references.map {|item| item.to_s},
        :referencedBy => expression.referencedBy.map {|item| item.to_s},
        :copies => expression.copies.map {|item| item.to_s},
        :copiedBy => expression.copiedBy.map {|item| item.to_s},
        :quotes => expression.quotes.map {|item| item.to_s},
        :quotedBy => expression.quotedBy.map {|item| item.to_s},
        :mentions => expression.mentions.map {|item| item.to_s},
				:isRelatedTo => expression.isRelatedTo.map {|item| item.to_s}
				#:wordcount => paratranscript.word_count,
        #:wordfrequency => paratranscript.word_frequency

      }

    render :json => expression_hash

	end

	def status
		url = "http://scta.info/resource/#{params[:itemid]}"
		resource = Lbp::Resource.find(url)
		@title = resource.title
		@manifestations = order_manifestations(resource)
		if @manifestations.count == 0
			flash.clear
		end
		render :status2
	end

	def show
		if params.has_key?(:search)
			flash.now[:notice] = "Search results for instances of #{params[:searchid]} (#{params[:search]}) are highlighted in yellow below."
		end

		# get expression and related info
		@expression = get_expression(params)

		@expression_structure = @expression.structure_type.short_id
		# perform checks
		check_transcript_existence(@expression)
		check_permission(@expression); return if performed?

		if @expression.status == "In Progress" || @expression.status == "draft"
			flash.now[:alert] = "Please remember: the status of this text is draft. You have been granted access through the generosity of the editor. Please use the comments to help make suggestions or corrections."
		end

		#get values  needed for view
		#@expressionid = params[:itemid]
		@title = @expression.title
		@next_expressionid = if @expression.next != nil then @expression.next.to_s.split("/").last else nil end
		@previous_expressionid = if @expression.previous != nil then @expression.previous.to_s.split("/").last else nil end

		#get transcription Object from params
		transcript = get_transcript(params)


		# ms_slugs is not great because its hard coding "critical"
    # what if the name of the manifestion for a critical manifestion was not called critical
    # more idea to check database to get a manifestationType
    # but this could be costly. If there were 20 or 30 manifestations
    # then you'd be making lots of requests to db
    # this map is reused in the paragraph controller as well; should be refactored
    ms_slugs = @expression.manifestations.map {|m| unless m.to_s.include? 'critical' then m.to_s.split("/").last end}.compact
		default_wit_param = ms_slugs[0]


		#prepare xslt arrays to be used for transformation
			#always remember single quotes for paramater value
			#specify if global image setting is true or false


		xslt_param_array = ["default-ms-image", if default_wit(params, @expression) == "critical" then "'#{default_wit_param}'" else "'#{default_wit(params, @expression)}'" end,
				"default-msslug", "'#{default_wit(params, @expression)}'",
				"show-images", "'#{@config.images.to_s}'",
				"by_phrase", "'#{t(:by)}'",
				"edited_by_phrase", "'#{t(:edited_by)}'"]

		#using "file" path, there is no longer any need to check the structure type; Exist will simply construct a new document
		#for the expression at any level in the hierarchy
		if params[:path] == "file"
			file = transcript.file(confighash: @config.confighash, path: params[:path])
			@transform = file.transform_main_view(xslt_param_array)
		else
			if @expression_structure == "structureItem"
				file = params[:branch] ? transcript.file(branch: params[:branch], confighash: @config.confighash, path: "doc") : transcript.file(confighash: @config.confighash, path: "doc")
				@transform = file.transform_main_view(xslt_param_array)
			elsif @expression_structure == "structureBlock"
				#path = params[:path] ? params[:path] : "doc"
				file = transcript.file_part(confighash: @config.confighash, partid: params[:itemid], path: "doc")
				@transform = file.transform_plain_text(xslt_param_array)
			end
		end
		@file_path = file.file_path.to_s
	end

	def xml
		expression = get_expression(params)
		@expression_structure = expression.structure_type.short_id

		check_permission(expression)

		transcript = get_transcript(params)

		if @expression_structure == "structureItem"
			file = transcript.file(confighash: @config.confighash)
			@nokogiri = file.nokogiri
		elsif @expression_structure == "structureBlock"
			# NOTE: don't be confused by item id here; it is the id of the block express
			# all :itemid should be interpreted as shortId of the expression.
			# the will eventually all be changed to "expressionid"
			file = transcript.file_part(confighash: @config.confighash, partid: params[:itemid])
			@nokogiri = file.xml
		end
	end
	def plain_text
		## TODO refactor: this code is almost identical to TOC except that
		## it chooses a different transform options at the very end
		expression = get_expression(params)
		@expression_structure = expression.structure_type.short_id

		check_permission(expression)

		transcript = get_transcript(params)

		if @expression_structure == "structureItem"
			file = transcript.file(confighash: @config.confighash)
		elsif @expression_structure == "structureBlock"
			# NOTE: itemid => expressionid
			file = transcript.file_part(confighash: @config.confighash, partid: params[:itemid])
		end
		@plaintext = file.transform_plain_text.to_s.gsub(/[\s]+/, "\s")
		render :plain => @plaintext
	end
	def clean
		## TODO refactor: this code is almost identical to TOC except that
		## it chooses a different transform options at the very end
		expression = get_expression(params)
		@expression_structure = expression.structure_type.short_id

		check_permission(expression)

		transcript = get_transcript(params)

		if @expression_structure == "structureItem"
			file = transcript.file(confighash: @config.confighash)
		elsif @expression_structure == "structureBlock"
			# NOTE: itemid => expressionid
			file = transcript.file_part(confighash: @config.confighash, partid: params[:itemid])
		end
		 @cleantext = file.transform_clean.gsub(/[\s]+/, "\s")
		#@cleantext = file.transform_clean;
		render :plain => @cleantext
	end
	def toc
		expression = get_expression(params)
		@expression_structure = expression.structure_type.short_id

		check_permission(expression)

		transcript = get_transcript(params)

		if @expression_structure == "structureItem"
			file = transcript.file(confighash: @config.confighash)
		elsif @expression_structure == "structureDivision"
			## until each structure division has its own
			## tei file, it will need to use the file_part class
			## and will need a method that can get the toc of just that part
		end
		@toc = file.transform_toc
		render :layout => false
	end

	def pdf
		@response = open("http://print.lombardpress.org/compile?id=#{params[:id]}&output=pdf").read
		redirect_to "http://" + JSON.parse(@response)["url"];


	end

	def draft_permissions

	end

	private

end
