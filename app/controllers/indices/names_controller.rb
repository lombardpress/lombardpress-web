class Indices::NamesController < ApplicationController
	def list
		commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		query = IndexQuery.new(commentaryurl)
		category = if params.has_key?("category") then params[:category] else "all" end
		@results = query.name_list(category)
	end
	def show
		commentaryurl = "http://scta.info/text/#{@config.commentaryid}/commentary"
		nameurl = "http://scta.info/resource/person/#{params[:nameid]}"
		query = IndexQuery.new(commentaryurl)
		@results = query.name_info(nameurl)
		@commentary_results = @results.dup.filter(:commentary => RDF::URI("#{commentaryurl}"))
		#@other_results = @results.dup.filter(:commentary => (RDF::URI("#{commentaryurl}"))
	end
	def categories
		@categories = ["All", "Arabic", "Biblical", "Classical", "Patristic", "Scholastic"]
	end

end
