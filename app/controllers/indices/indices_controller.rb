class Indices::IndicesController < ApplicationController
	def index
		@indices = ["Names", "Works", "Quotations"]
	end
end