module TextMethods
  extend ActiveSupport::Concern

  def get_item(params)
		shortid = params[:itemid]
		resource = Lbp::Resource.new(shortid).convert
	end
	def get_expression(shortid)
		expression = Lbp::Expression.new(shortid)
	end

		def check_permission(expression)
			if expression.status == "In Progress" || expression.status == "draft"
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
		def get_shortid(params)
			if params.has_key? :transcriptslug
				shortid = "#{params[:itemid]}/#{params[:msslug]}/#{params[:transcriptslug]}" 
			elsif params.has_key? :msslug
				shortid = "#{params[:itemid]}/#{params[:msslug]}"
			else
				shortid = "#{params[:itemid]}"
			end
		end
		def get_transcript(params)
			# get short id of either expression, manifestation, or transcription from paramaters
			shortid = get_shortid(params)
			#construct the resource url
			resource_url = "http://scta.info/resource/#{shortid}"
			# get the resource class object
			resource = Lbp::Resource.new(resource_url)
			
			#this conditional helps avoid a redundant call for the expression object
			#since the expression object always gets called in the show 
			#command to get basic info about status etc. 
			#if this makes things to muddy the conditional could be removed and
			#replaced with simply `resource_subclass=resource.convert

			#i'm concerned about this conditional as I'm not quite sure how the && @expression is working
			#yet the conditional seems to work only when this second condition is present
			unless resource.type_shortId == "expression" && @expression != nil
				resource_subclass = resource.convert
			else
				resource_subclass = @expression
			end
			# return the transcription object to be used
			unless resource_subclass.class == Lbp::Transcription
				return transcriptObj = resource_subclass.canonicalTranscription
			else
				# here it is assumed the subclass is already a Transcription class
				return resource_subclass
			end
		end
		def check_transcript_existence(item, params)
			wit = default_wit(params)
				unless item.transcription?(wit)
					redirect_to "/text/status/#{params[:itemid]}", :alert => "A critical/normalized edition of this text does not exist yet. Below are the available transcriptions." and return
		end
		
	end
end