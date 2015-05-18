class ArticlesController < ApplicationController
	def index
	end
	def show
		#this logic needs to be moved outside the controller
		article = @config.articles.select{|article| article.article_name == params[:articleid]}.first
		
		xslt_file_path = "#{Rails.root}/#{article.xslt_file}"
		xml_file_path = article.xml_file

		xml_file = open(xml_file_path, {:http_basic_authentication => [ENV["GUN"], ENV["GPW"]]})
		nokogiri_doc = Nokogiri::XML(xml_file)
		
		xslt = Nokogiri::XSLT(open(xslt_file_path))
		
		@transform = xslt.apply_to(nokogiri_doc)
	end
end
