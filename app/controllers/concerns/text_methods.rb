module TextMethods
  extend ActiveSupport::Concern

  def get_item(params)
			config_hash = @config.confighash
			commentaryid = @config.commentaryid
			url = "http://scta.info/text/#{commentaryid}/item/#{params[:itemid]}"
			item = Lbp::Item.new(config_hash, url)
		end

		def check_permission(item)
			
			if item.status == "In Progress" || item.status == "draft"
				if current_user.nil?
					redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
				elsif current_user.draft_reader? 
					allowed_texts = current_user.access_points.map {|access_point| {access_point.itemid =>access_point.commentaryid} }
					unless allowed_texts.include? params[:itemid] => @config.commentaryid or allowed_texts.include? "all" => @config.commentaryid
						redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
					end
				elsif !current_user.admin? 
					redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
				end
			end
		end
		def default_wit(params)
			if params.has_key?(:msslug) then params[:msslug] else "critical" end
		end
		def get_transcript(item, params, source="origin")
			wit = default_wit(params)
			transcript = item.transcription(source: source, wit: wit)
		end
		def check_transcript_existence(item, params)
			wit = default_wit(params)
				unless item.transcription?(wit)
					redirect_to "/text/status/#{params[:itemid]}", :alert => "A critical/normalized edition of this text does not exist yet. Below are the available transcriptions." and return
		end
		
	end
end