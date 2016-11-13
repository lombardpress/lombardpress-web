class ParagraphimageController < ApplicationController
	# i'm pretty sure this method "show" is not being used at all. and shoudl be removed
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

		#TODO: not ideal to be hardcoding "transcription" here. If there were more than one transcription
		# of this manifestation there would be a problem
		transcripturl = "http://scta.info/resource/#{params[:itemid]}/#{params[:msslug]}/transcription"

		results = MiscQuery.new.zone_info(transcripturl)

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
		# this condition should be temporary
		# as eventually tei milestones should identify their canvas url
		# right now the this requires three extra DB calls.
		# the else side of the conditional is much preferred.
		####
		# it is surprisingly fast for three extra calls
		# maybe I shouldn't worry about that so much

		##THIS SHOULD NO LONGER BE NEEDED; DELETE AFTER 0.6.0 release
		# if params[:canvasid].include? "xxx-"
		# 	exBlockObj = Lbp::Expression.find(params[:expressionid])
		#
		# 	#expItemId = exBlockObj.results.dup.filter(:p => RDF::URI("http://scta.info/property/isPartOfStructureItem")).first[:o].to_s
		# 	expItemId = exBlockObj.value("http://scta.info/property/isPartOfStructureItem").to_s
		# 	expItemObj = Lbp::Expression.find(expItemId)
		# 	expTopId = expItemObj.value("http://scta.info/property/isPartOfTopLevelExpression").to_s
		# 	expTopObj = Lbp::Expression.find(expTopId)
		# 	#commentary_slug = expTopObj.results.dup.filter(:p => RDF::URI("http://scta.info/property/slug")).first[:o]
		# 	commentary_slug = expTopObj.value("http://scta.info/property/slug").to_s
		# 	canvasid = params[:canvasid].sub('xxx-', "#{commentary_slug}-")
		# else
		# 	canvasid = params[:canvasid]
		# end

		#results = MiscQuery.new.folio_info(canvasid)
		full_surfaceid = "http://scta.info/resource/#{params[:surfaceid]}"
		results = MiscQuery.new.folio_info2(full_surfaceid)

		@image_info = {
			:image_url => results.first[:imageurl].to_s,
			:next_shortid => if results.first[:next_surface] then results.first[:next_surface].to_s.split("resource/").last else nil end,
			:previous_shortid => if results.first[:previous_surface] then results.first[:previous_surface].to_s.split("resource/").last else nil end, 
		}

		render :json => @image_info
	end

end
