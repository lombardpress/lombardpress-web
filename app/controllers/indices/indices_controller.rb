class Indices::IndicesController < ApplicationController
	def index
		@indices = ["Names", "Works", "Quotations", "Subject"]
	end
end