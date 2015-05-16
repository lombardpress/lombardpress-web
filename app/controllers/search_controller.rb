class SearchController < ApplicationController
	def show

		#@results = open("http://localhost:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}").read
		param_hash = {query: params[:searchterm], commentarid: @config.commentaryid}.to_query
		url = "http://sparql.scta.info:8080/exist/apps/scta/wordsearch.xq?" + param_hash
		@results = open("http://sparql.scta.info:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}", 
			{:http_basic_authentication => [ENV['EXISTUN'], ENV['EXISTPW']]}).read
		
	end
end
