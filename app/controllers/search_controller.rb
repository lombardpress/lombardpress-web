class SearchController < ApplicationController
	def show
		@results = open("http://localhost:8080/exist/rest/db/xQueries/plainTextSearch3.xql?param1=#{params[:searchterm]}").read
		
	end
end
