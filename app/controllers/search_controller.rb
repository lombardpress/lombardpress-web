class SearchController < ApplicationController
	def show

		expressionid = params[:expressionid] ? params[:expressionid] : "all"
		#@results = open("http://localhost:8080/exist/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{@config.commentaryid}").read
		#param_hash = {query: params[:searchterm], commentaryid: @config.commentaryid}.to_query
		#url = "http://sparql.scta.info:8080/exist/apps/scta/wordsearch.xq?query" + param_hash[]
		@results = open("http://exist.scta.info/exist/rest/db/apps/scta/wordsearch.xq?query=#{params[:searchterm]}&commentaryid=#{expressionid}").read 
		#@results = open(url).read 
			#{:http_basic_authentication => ["reader", "READER"]}).read
		
	end
end
