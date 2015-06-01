class ParagraphimageController < ApplicationController
	def show
		config_hash = @config.confighash
		commentaryid = @config.commentaryid

		url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"


		item = Lbp::Item.new(config_hash, url)
		paragraph = item.transcription(wit: params[:msslug], source: "origin").paragraph(params[:pid])
		number_of_zones = paragraph.number_of_zones
		
		@paragraph_text = paragraph.transform("#{Rails.root}/xslt/default/documentary/documentary_simple.xsl")

		@next_para = paragraph.next
		@previous_para = paragraph.previous
		@paragraph_number = paragraph.number
		
		

		@ms_slugs = item.transcription_slugs.map {|slug| unless slug == params[:itemid] then slug.split("_").first end}
		@para_images = []
		@i = 1
		while @i < number_of_zones + 1 
			 #@para_images << Lbp::ParagraphImage.new(config_hash, file_hash, params[:pid], @i)
			 paragraphurl = "http://scta.info/text/#{commentaryid}/transcription/#{params[:msslug]}_#{params[:itemid]}/paragraph/#{params[:pid]}"
			 @para_images << paragraphurl = Lbp::ParagraphImage.new(paragraphurl, @i)
			 @i = @i + 1
		end
	
	end
	def showzoom
		
		commentaryid = @config.commentaryid
		paragraphurl = "http://scta.info/text/#{commentaryid}/transcription/#{params[:msslug]}_#{params[:itemid]}/paragraph/#{params[:pid]}"
		#paragraphurl = "http://scta.info/text/#{commentaryid}/transcription/sorb_#{params[:itemid]}/paragraph/#{params[:pid]}" # test for sorb f. 2
		results = MiscQuery.new.zone_info(paragraphurl)
		
		@para_images = []
		
		
		
		results.each do |result|
			totalW = result[:totalWidth].to_s.to_f
			totalH = result[:totalHeight].to_s.to_f
			aspectratio = totalH / totalW
			scale = 600 / result[:width].to_s.to_f 

			@image_info = {
				:scale => scale,
				:bottom => result[:lry].to_s.to_i * scale,
				:right => result[:lrx].to_s.to_i * scale,
				:top => result[:uly].to_s.to_i * scale,
				:left => result[:ulx].to_s.to_i * scale,
				:width => result[:width].to_s.to_i * scale,
				:height => result[:height].to_s.to_i * scale,
				:totalW => totalW * scale,
				:totalH => totalH * scale,
				:aspectratio => aspectratio,
				:xcomp => (result[:ulx].to_s.to_i / totalW),
				:ycomp => (result[:uly].to_s.to_i / totalH) * aspectratio,
				:heightcomp => (result[:height].to_s.to_i / totalH) * aspectratio,
				:widthcomp => result[:width].to_s.to_i / totalW,
				:image_url => result[:imageurl]
				
			}
			@para_images << @image_info

		end
		render :json => @para_images
	
	end
	def showfoliozoom
		#add commentaryslug to Settings config; then this will be fully automated
		commentary_slug = Lbp::Collection.new(@config.confighash, "http://scta.info/text/#{@config.commentaryid}/commentary").slug
		manifest_slug = commentary_slug + "-" + params[:msslug]
		canvasid = "http://scta.info/iiif/#{manifest_slug}/canvas/#{params[:canvas_id]}"
		
		results = MiscQuery.new.folio_info(canvasid)
		@image_info = {
			:image_url => results.first[:imageurl].to_s
		}
		
		render :json => @image_info
	end

end
