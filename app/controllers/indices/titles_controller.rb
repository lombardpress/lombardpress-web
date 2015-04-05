class Indices::TitlesController < ApplicationController
	def list
		commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		query = IndexQuery.new(commentaryurl)
		category = if params.has_key?("category") then params[:category] else "all" end
		@results = query.title_list(category)
		
	end
	def show
		commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		titleurl = "http://scta.info/resource/work/#{params[:titleid]}"
		query = IndexQuery.new(commentaryurl)
		@results = query.title_info(titleurl)
		@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
			
	end
	def categories
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]
		
	end

end