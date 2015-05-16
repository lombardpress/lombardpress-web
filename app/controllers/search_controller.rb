class SearchController < ApplicationController
	def show
		#@results = open("http://localhost:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}").read
		@results = open("http://sparql.scta.info:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}", 
			{:http_basic_authentication => [ENV['EXISTUN'], ENV['EXISTPW']]}).read
		
	end
end
