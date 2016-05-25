class Indices::TitlesController < ApplicationController
	include IndexMethods
	def list
		unless params[:expressionid] == nil
			expressionid = "http://scta.info/resource/#{params[:expressionid]}"
		else
			expressionid = "http://scta.info/resource/plaoulcommentary"
		end
		#query = IndexQuery.new(commentaryurl)
		#category = if params.has_key?("category") then params[:category] else "all" end
		#@results = query.title_list(category)
		
		query = Lbp::Query.new
		category = if params.has_key?("category") then params[:category] else "all" end
		#@results = query.name_list(category)
		@raw_results = query.expressionElementQuery(expressionid, "http://scta.info/resource/structureElementTitle")

		filter_index_query(@raw_results)
		return @results
	end
	def show
		#commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		titleurl = "http://scta.info/resource/work/#{params[:titleid]}"
		query = IndexQuery.new(titleurl)
		@results = query.expression_element_info(titleurl)
		#@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
			
	end
	def categories
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]
		
	end

end