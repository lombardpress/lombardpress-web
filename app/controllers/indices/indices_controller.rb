class Indices::IndicesController < ApplicationController
	def index
		@indices = ["Names", "Works", "Quotations"]
		@expressionid = !params[:expressionid].nil? ? params[:expressionid] : "scta"
	end
end