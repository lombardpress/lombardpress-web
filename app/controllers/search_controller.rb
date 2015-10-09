class SearchController < ApplicationController
	def show

		#@results = open("http://localhost:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}").read
		param_hash = {query: params[:searchterm], commentarid: @config.commentaryid}.to_query
		url = "http://sparql.scta.info:8080/exist/apps/scta/wordsearch.xq?" + param_hash
		@results = open("http://exist.scta.info/exist/rest/db/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}").read 
			#{:http_basic_authentication => ["reader", "READER"]}).read
		
	end
end
