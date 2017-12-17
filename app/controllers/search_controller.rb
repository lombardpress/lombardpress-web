class SearchController < ApplicationController
	def show
		if params[:type] == 'questions'
			expressionid = if !params[:expressionid].blank? then "http://scta.info/resource/#{params[:expressionid]}" else nil end
			expressiontypeid = if !params[:expressiontypeid].blank? then "http://scta.info/resource/#{params[:expressiontypeid]}" else nil end
			authorid = if !params[:authorid].blank? then "http://scta.info/resource/#{params[:authorid]}" else nil end
			workgroupid = if !params[:workgroupid].blank? then "http://scta.info/resource/#{params[:workgroupid]}" else nil end
			searchterm = if !params[:searchterm].blank? then params[:searchterm] else '' end
			search = Search.new()
			@results = search.questions(expressionid: expressionid, searchterm: searchterm, authorid: authorid, workGroupId: workgroupid, expressiontypeid: expressiontypeid)
			if @results.nil?
				@results = []
			end

			render :questions_new
		else
			if !params[:expressiontypeid].blank?
				expressiontypeid = params[:expressiontypeid] ? params[:expressiontypeid] : "all"
				@results = open("http://exist.scta.info/exist/apps/scta-app/search/expressiontype/#{params[:expressiontypeid]}?query=#{params[:searchterm]}").read
			elsif !params[:authorid].blank?
				@results = open("http://exist.scta.info/exist/apps/scta-app/search/author/#{params[:authorid]}?query=#{params[:searchterm]}").read
			elsif !params[:workgroupid].blank?
				@results = open("http://exist.scta.info/exist/apps/scta-app/search/workgroup/#{params[:workgroupid]}?query=#{params[:searchterm]}").read
			elsif !params[:expressionid].blank?
				expressionid = params[:expressionid] ? params[:expressionid] : "all"
				@results = open("http://exist.scta.info/exist/apps/scta-app/search/expression/#{expressionid}?query=#{params[:searchterm]}").read
			else
				expressionid = "all"
				if params[:searchterm].blank?
					@results = "No search term provided"
				else
					@results = open("http://exist.scta.info/exist/apps/scta-app/search/expression/#{expressionid}?query=#{params[:searchterm]}").read
				end
			end

			render :show
		end


	end
	def questions
		@searchterm = params[:searchterm]
		unless @searchterm == nil || @searchterm == ""
			predicate = "<http://scta.info/property/questionTitle>"
		  query = "
				SELECT ?resource ?resource_short_id ?resource_title ?resource_status ?qtitle ?author_title ?author_short_id ?toplevel_expression ?toplevel_expression_title ?toplevel_expression_short_id ?structure_type ?parent_item ?parent_item_title ?parent_item_short_id ?parent_item_author ?parent_item_author_title ?parent_item_author_short_id ?parent_item_status
	      {
	      	?resource #{predicate} ?qtitle  .
					FILTER (REGEX(STR(?qtitle), '#{@searchterm}', 'i')) .
					?resource <http://purl.org/dc/elements/1.1/title> ?resource_title .
					?resource <http://scta.info/property/structureType> ?structure_type .
					OPTIONAL
					{
						?resource <http://scta.info/property/shortId> ?resource_short_id	.
					}
					OPTIONAL
					{
						?resource <http://www.loc.gov/loc.terms/relators/AUT> ?author	.
						?author <http://purl.org/dc/elements/1.1/title> ?author_title .
						?author <http://scta.info/property/shortId> ?author_short_id .
					}
					OPTIONAL
					{
						?resource <http://scta.info/property/status> ?resource_status	.
					}
					OPTIONAL
					{
						?resource <http://scta.info/property/isPartOfTopLevelExpression> ?toplevel_expression	.
						?toplevel_expression <http://purl.org/dc/elements/1.1/title> ?toplevel_expression_title .
						?toplevel_expression <http://scta.info/property/shortId> ?toplevel_expression_short_id .
					}
					OPTIONAL
					{
						?resource <http://scta.info/property/isPartOfStructureItem> ?parent_item	.
						?parent_item <http://purl.org/dc/elements/1.1/title> ?parent_item_title .
						?parent_item <http://scta.info/property/shortId> ?parent_item_short_id .
						?parent_item <http://scta.info/property/status> ?parent_item_status .
						?parent_item <http://www.loc.gov/loc.terms/relators/AUT> ?parent_item_author .
						?parent_item_author <http://purl.org/dc/elements/1.1/title> ?parent_item_author_title .
						?parent_item_author <http://scta.info/property/shortId> ?parent_item_author_short_id .
					}

	      }
				ORDER BY ?resource
		  "
			query_obj = Lbp::Query.new()
			@results = query_obj.query(query)
		else
			@results = []
		end

	end
end
