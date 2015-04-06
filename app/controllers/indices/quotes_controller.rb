class Indices::QuotesController < ApplicationController
	def list
		commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		query = IndexQuery.new(commentaryurl)
		category = if params.has_key?("category") then params[:category] else "All" end
		@results = query.quote_list(category)
		
	end
	def show
		commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		quoteurl = "http://scta.info/resource/quotation/#{params[:quoteid]}"
		query = IndexQuery.new(commentaryurl)
		@results = query.quote_info(quoteurl)
		@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
			
	end
	def categories
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]
		
	end

end