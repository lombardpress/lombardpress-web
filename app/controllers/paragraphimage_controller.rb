class ParagraphimageController < ApplicationController
	def show
		config_hash = @config.confighash
		commentaryid = @config.commentaryid
		url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"


		item = Lbp::Item.new(config_hash, url)
		paragraph = item.transcription(wit: params[:msslug], source: "origin").paragraph(params[:pid])
		@paragraph_text = paragraph.transform("#{Rails.root}/xslt/default/documentary/documentary_simple.xsl")

		@next_para = paragraph.next
		@previous_para = paragraph.previous
		@paragraph_number = paragraph.number
		
		# it would be best to be able to build a paragraph image from the Item, 
		# like item.transcription.paragraph.paragraphImage
		file_hash = item.file_hash(source: 'origin', wit: params[:msslug], ed: 'master')

		@ms_slugs = item.transcription_slugs.map {|slug| unless slug == params[:itemid] then slug.split("_").first end}
		@paraimage = Lbp::ParagraphImage.new(config_hash, file_hash, params[:pid])
		
	end
end
