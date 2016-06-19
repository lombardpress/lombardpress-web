class Indices::TitlesController < ApplicationController
	include IndexMethods
	def list
		unless params[:expressionid] == "all" || params[:expressionid] == "scta"
			expressionid = "http://scta.info/resource/#{params[:expressionid]}"
			@expressionid = expressionid.split("/").last
			#query = IndexQuery.new(commentaryurl)
			#category = if params.has_key?("category") then params[:category] else "all" end
			#@results = query.title_list(category)
			
			query = Lbp::Query.new
			category = if params.has_key?("category") then params[:category] else "all" end
			#@results = query.name_list(category)
			@raw_results = query.expressionElementQuery(expressionid, "http://scta.info/resource/structureElementTitle")

			filter_index_query(@raw_results)
			return @results
		else
			@expressionid = "scta"
			query_obj = IndexQuery.new("http://scta.info/resource/scta")
			@results = query_obj.name_person_quote_list("http://scta.info/resource/work")
			return @results
		end
		
	end
	def show
		#commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		titleurl = "http://scta.info/resource/#{params[:titleid]}"
		query = IndexQuery.new(titleurl)
		unless params[:expressionid] == "all" || params[:expressionid] == "scta"
			expression_scope = "http://scta.info/resource/#{params[:expressionid]}"
			@results = query.expression_element_info(titleurl, expression_scope)
		else
			@results = query.expression_element_info(titleurl)
		end
		
		#@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
			
	end
	def categories
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]
		
	end

end