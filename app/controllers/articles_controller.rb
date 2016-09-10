class ArticlesController < ApplicationController
	def index
		## TODO need sparql query that retrieves all articles with ability to filter by commentary or author
	end
	def show

		#article = Lbp::Article.new(params[:articleid])
		article = Lbp::Resource.find(params[:articleid])
		article_type = article.article_type_shortId

		if article_type == "bibliography"
			xslt_file_path = "#{Rails.root}/xslt/articles/bibliography.xsl"
		elsif article_type == "about"
			xslt_file_path = "#{Rails.root}/xslt/articles/standard.xsl"
		elsif article_type == "timeline"
			xslt_file_path = "#{Rails.root}/xslt/articles/timeline.xsl"
		elsif article_type == "biography"
			xslt_file_path = "#{Rails.root}/xslt/articles/biography.xsl"
		elsif article_type == "manuscriptlist"
			xslt_file_path = "#{Rails.root}/xslt/articles/bibliography.xsl"
		else
			xslt_file_path = "#{Rails.root}/xslt/articles/standard.xsl"
		end

		xml_file_path = article.file_path

		xml_file = open(xml_file_path, {:http_basic_authentication => [ENV["GUN"], ENV["GPW"]]})
		nokogiri_doc = Nokogiri::XML(xml_file)


		xslt = Nokogiri::XSLT(open(xslt_file_path))

		@transform = xslt.apply_to(nokogiri_doc)
	end
end
