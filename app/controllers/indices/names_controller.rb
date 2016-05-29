class Indices::NamesController < ApplicationController
	include IndexMethods

	## TODO: RE-ROUTING and category filters still required
	## query should also be adjusted to handle searches for WorkGroups and Structrure Items and Divsions
	## currently only supports StructureCollections
	## This is true for quotes and titles as weel
	## TODO: comment out subject indices until that its betters established
	def list
		unless params[:expressionid] == nil
			expressionid = "http://scta.info/resource/#{params[:expressionid]}"
		else
			expressionid = "http://scta.info/resource/plaoulcommentary"
		end
		#query = IndexQuery.new(commentaryurl)
		query = Lbp::Query.new
		category = if params.has_key?("category") then params[:category] else "all" end
		#@results = query.name_list(category)
		@raw_results = query.expressionElementQuery(expressionid, "http://scta.info/resource/structureElementName")
		filter_index_query(@raw_results)
		return @results
	end
	def show
		nameurl = "http://scta.info/resource/person/#{params[:nameid]}"
		query = IndexQuery.new(nameurl)
		@results = query.expression_element_info(nameurl)
		
		#@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
	end
	def categories
		
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]

	end

end
