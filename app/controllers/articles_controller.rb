class ArticlesController < ApplicationController
	def index
	end
	def show
		#this logic needs to be moved outside the controller
		article = Article.new(@config)
		
		xslt_file_path = article.xslt_file(params[:articleid].to_sym)
		xml_file_path = article.xml_file(params[:articleid].to_sym)

		xml_file = open(xml_file_path, {:http_basic_authentication => [ENV["GUN"], ENV["GPW"]]})
		nokogiri_doc = Nokogiri::XML(xml_file)
		
		xslt = Nokogiri::XSLT(open(xslt_file_path))
		
		@transform = xslt.apply_to(nokogiri_doc)
	end
end
