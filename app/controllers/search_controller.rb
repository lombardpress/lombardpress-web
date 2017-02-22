class SearchController < ApplicationController
	def show
		if params[:use] == "sparql"
			expressionid = params[:expressionid] ? params[:expressionid] : "all"
			@results = open("http://exist.scta.info/exist/rest/db/apps/scta/search-with-sparql.xq?query=#{params[:searchterm]}&expressionid=#{expressionid}").read
		elsif params[:use] == "author"
			@results = open("http://exist.scta.info/exist/apps/scta-app/search/author/#{params[:authorid]}/#{params[:searchterm]}").read
		else
		expressionid = params[:expressionid] ? params[:expressionid] : "all"
		#@results = open("http://localhost:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}").read
		#param_hash = {query: params[:searchterm], commentaryid: @config.commentaryid}.to_query
		#url = "http://sparql.scta.info:8080/exist/apps/scta/wordsearch.xq?query" + param_hash[]
		@results = open("http://exist.scta.info/exist/rest/db/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{expressionid}").read
		#@results = open(url).read
			#{:http_basic_authentication => ["reader", "READER"]}).read
		end


	end
	def questions
		@searchterm = params[:searchterm]
		unless @searchterm == ""
			predicate = "<http://scta.info/property/questionTitle>"
		  query = "
				SELECT ?resource ?resource_short_id ?resource_title ?qtitle ?author_title ?author_short_id ?toplevel_expression ?toplevel_expression_title ?toplevel_expression_short_id ?structure_type ?parent_item ?parent_item_title ?parent_item_short_id ?parent_item_author ?parent_item_author_title ?parent_item_author_short_id
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
						?resource <http://scta.info/property/isPartOfTopLevelExpression> ?toplevel_expression	.
						?toplevel_expression <http://purl.org/dc/elements/1.1/title> ?toplevel_expression_title .
						?toplevel_expression <http://scta.info/property/shortId> ?toplevel_expression_short_id .
					}
					OPTIONAL
					{
						?resource <http://scta.info/property/isPartOfStructureItem> ?parent_item	.
						?parent_item <http://purl.org/dc/elements/1.1/title> ?parent_item_title .
						?parent_item <http://scta.info/property/shortId> ?parent_item_short_id .
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
