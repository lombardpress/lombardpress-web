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

		if params[:transcriptionid]
			transcription = Lbp::Resource.find("#{params[:articleid]}/#{params[:transcriptionid]}")
			xml_file_path = transcription.file_path
		else
			transcription = article.canonical_transcription.resource
			xml_file_path = transcription.file_path
		end

		xml_file = open(xml_file_path)
		nokogiri_doc = Nokogiri::XML(xml_file)
		xml_file.close

		xslt_file = open(xslt_file_path)
		xslt = Nokogiri::XSLT(xslt_file)
		xslt_file.close
		
		@current_order_number = transcription.value("http://scta.info/property/versionOrderNumber")
		@current_version_label = transcription.value("http://scta.info/property/versionLabel")
		@transform = xslt.apply_to(nokogiri_doc)
		@version_history = MiscQuery.new.version_history_info(transcription.to_s)

	end
end
