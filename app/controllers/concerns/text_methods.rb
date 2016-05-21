module TextMethods
  extend ActiveSupport::Concern

  def get_item(params)
			#config_hash = @config.confighash
			#commentaryid = @config.commentaryid
			#url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"
			shortid = params[:itemid]
			#item = Lbp::Item.new(config_hash, shortid)
			item = Lbp::Expression.new(shortid)
		end

		def check_permission(item)
			if item.status == "In Progress" || item.status == "draft"
				if current_user.nil?
					redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
				elsif !current_user.admin? 
					allowed_texts = current_user.access_points.map {|access_point| {access_point.itemid =>access_point.commentaryid} }
					unless allowed_texts.include? params[:itemid] => @config.commentaryid or allowed_texts.include? "all" => @config.commentaryid
						redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
					end
				# if user is logged in and is admin, no redirect should occur, thus there is no final "else" statment
				end 
			end
		end
		def default_wit(params)
			if params.has_key?(:msslug) then params[:msslug] else "critical" end
		end
		def get_transcript(item, params, source="origin")
			wit = default_wit(params)
			shortid = params[:itemid]
			
			# transcription is requested by asking by calling the transcription method
			# on the expression/item. the transcription method at the express level requests
			# the cananonical transcription on the canonical manifestation
			transcriptObj = item.transcription("http://scta.info/resource/#{shortid}/#{wit}")
			return transcriptObj
		end
		def check_transcript_existence(item, params)
			wit = default_wit(params)
				unless item.transcription?(wit)
					redirect_to "/text/status/#{params[:itemid]}", :alert => "A critical/normalized edition of this text does not exist yet. Below are the available transcriptions." and return
		end
		
	end
end