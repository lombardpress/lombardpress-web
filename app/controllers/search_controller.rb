class SearchController < ApplicationController
	def show
		if params[:use] == "expressiontype"
			expressionid = params[:expressionid] ? params[:expressionid] : "all"
			@results = open(open("http://exist.scta.info/exist/apps/scta-app/search/expressiontype/#{params[:expressionid]}?query=#{params[:searchterm]}")).read
		elsif params[:use] == "author"
			@results = open("http://exist.scta.info/exist/apps/scta-app/search/author/#{params[:authorid]}?query=#{params[:searchterm]}").read
		elsif params[:use] == "workgroup"
			@results = open("http://exist.scta.info/exist/apps/scta-app/search/workgroup/#{params[:workgroupid]}?query=#{params[:searchterm]}").read
		else
			expressionid = params[:expressionid] ? params[:expressionid] : "all"
			@results = open("http://exist.scta.info/exist/apps/scta-app/search/expression/#{expressionid}?query=#{params[:searchterm]}").read
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
