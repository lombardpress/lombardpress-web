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
		
		scale = 0.5
		# not yet sure where to get this informations besides the IIIF manifest.
		totalW = 2070.0 # use for Plaoul test
		#totalW = 1865.0
		totalH = 2862.0
		#totalH = 2401.0 #use for Plaoul test
		aspectratio = totalH / totalW
		
		results.each do |result|
			
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
				:image_url => "http://images.scta.info:3000/pg-lon/" + result[:canvasurl].to_s.split("/").last + ".jpg"
				#:image_url => "http://gallica.bnf.fr/iiif/ark:/12148/btv1b52000459k/f5" # test for sorb fol. 2

			}
			@para_images << @image_info

		end
		render :json => @para_images


# what is commented below but the performance is pales in comparsion to the above.
=begin
		@i = 1
		config_hash = @config.confighash
		commentaryid = @config.commentaryid
		url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"
		item = Lbp::Item.new(config_hash, url)

		paragraph = item.transcription(wit: params[:msslug], source: "origin").paragraph(params[:pid])
		number_of_zones = paragraph.number_of_zones
		file_hash = item.file_hash(source: 'origin', wit: params[:msslug], ed: 'master')

		@para_images = []
		@i = 1
		while @i < number_of_zones + 1 
		
			@para_image = Lbp::ParagraphImage.new(config_hash, file_hash, params[:pid], @i)
			
			image_url = @para_image.url
			image_url = "http://images.scta.info:3000/pg-lon/#{image_url}"
			scale = 0.5
			
			left = @para_image.ulx
			right = @para_image.lrx
			## note; notice how getting width in this way is more efficient than calling @para_image.width
			## since this method would recall methods .ulx and .lrx again. 
			## does this signify a problem with my underlying library or is it normal to have inefficiencies like 
			## this in OOP
			width = right - left

			top = @para_image.uly
			bottom = @para_image.lry
			
			height = bottom - top

			# not yet sure where to get this informations besides the IIIF manifest.
			totalW = 2070.0
			totalH = 2862.0

			aspectratio = totalH / totalW


			@image_info = {
				:scale => scale,
				:bottom => bottom * scale,
				:right => right * scale,
				:top => top * scale,
				:left => left * scale,
				:width => width * scale,
				:height => height * scale,
				:totalW => totalW * scale,
				:totalH => totalH * scale,
				:aspectratio => aspectratio,
				:xcomp => (left / totalW),
				:ycomp => (top / totalH) * aspectratio,
				:heightcomp => (height / totalH) * aspectratio,
				:widthcomp => width / totalW,
				:image_url => image_url
			}
			@para_images << @image_info
			@i = @i + 1
		end
		#render :layout => false
		render :json => @para_images
=end		
	end
end
