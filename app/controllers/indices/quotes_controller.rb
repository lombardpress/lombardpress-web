class Indices::QuotesController < ApplicationController
	include IndexMethods
	def list
		unless params[:expressionid] == nil
			expressionid = "http://scta.info/resource/#{params[:expressionid]}"
			#query = IndexQuery.new(commentaryurl)
			#category = if params.has_key?("category") then params[:category] else "All" end
			#@results = query.quote_list(category)
			query = Lbp::Query.new
			category = if params.has_key?("category") then params[:category] else "all" end
			#@results = query.name_list(category)
			@raw_results = query.expressionElementQuery(expressionid, "http://scta.info/resource/structureElementQuote")
			filter_index_query(@raw_results)
			return @results
		else
			query_obj = IndexQuery.new("http://scta.info/resource/scta")
			@results = query_obj.name_person_quote_list("http://scta.info/resource/quotation")
			return @results
		end
		
	end
	def show
		#commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		quoteurl = "http://scta.info/resource/#{params[:quoteid]}"
		query = IndexQuery.new(quoteurl)
		@results = query.expression_element_info(quoteurl)
		#@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
			
	end
	def categories
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]
		
	end

end