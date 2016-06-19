class Indices::NamesController < ApplicationController
	include IndexMethods

	## TODO: RE-ROUTING and category filters still required
	## query should also be adjusted to handle searches for WorkGroups and Structrure Items and Divsions
	## currently only supports StructureCollections
	## This is true for quotes and titles as weel
	## TODO: comment out subject indices until that its betters established
	def list
		unless params[:expressionid] == "all" || params[:expressionid] == "scta"
			expressionid = "http://scta.info/resource/#{params[:expressionid]}"
			@expressionid = expressionid.split("/").last
			#query = IndexQuery.new(commentaryurl)
			query = Lbp::Query.new
			category = if params.has_key?("category") then params[:category] else "all" end
			#@results = query.name_list(category)
			@raw_results = query.expressionElementQuery(expressionid, "http://scta.info/resource/structureElementName")
			filter_index_query(@raw_results)
			return @results
		else
			@expressionid = "scta"
			query_obj = IndexQuery.new("http://scta.info/resource/scta")
			@results = query_obj.name_person_quote_list("http://scta.info/resource/person")
			return @results
		end
	end
	def show
		nameurl = "http://scta.info/resource/#{params[:nameid]}"
		
		query = IndexQuery.new(nameurl)
		unless params[:expressionid] == "all" || params[:expressionid] == "scta"
			expression_scope = "http://scta.info/resource/#{params[:expressionid]}"
			@results = query.expression_element_info(nameurl, expression_scope)
		else
			@results = query.expression_element_info(nameurl)
		end
		
	end
	def categories
		
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]

	end

end
