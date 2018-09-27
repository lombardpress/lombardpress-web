module TextMethods
  extend ActiveSupport::Concern

  def get_item(params)
		shortid = params[:itemid]
		resource = Lbp::Resource.find(shortid)
	end
	def get_expression(params)
		expression = Lbp::Expression.find(params[:itemid])
	end

		def check_permission(expression)
			if expression.status == "private-draft"
				if current_user.nil?
					redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
				elsif !current_user.admin?
					# begin collecting allow structureItems
					allowed_items = current_user.access_points.map {|access_point| access_point.itemid}
					# collecting allowed topLevelExpressions
					allowed_top_level_collection = current_user.access_points.map {|access_point| access_point.commentaryid}
					# get topLevel expression that structureItem expression belongs to
					toplevelexpressionid = expression.top_level_expression_shortId
					#begins test
					if !allowed_items.include? expression.short_id and !allowed_top_level_collection.include? toplevelexpressionid
						redirect_to "/text/draft_permissions/#{params[:itemid]}", :alert => "Access denied: This text is a draft. It requires permission to be viewed." and return
					end
					# if user is logged in and is admin, no redirect should occur, thus there is no final "else" statment
				end
			end
		end
		## TODO: test and see if this being, used. Seems obsolute now that
		# I can use canonicalManifestion and canonicalWitness methods
		def default_wit(params, expression)
			if params.has_key?(:msslug)
         params[:msslug]
       else
         expression.canonical_manifestation.short_id.split("/").last
       end
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
			if params[:url]
				resource_url = params[:url]
			else
				# get short id of either expression, manifestation, or transcription from paramaters
				shortid = get_shortid(params)
				#construct the resource url
				resource_url = "http://scta.info/resource/#{shortid}"
			end
			# get the resource class object
			# TODO: someting about this feels redundant
			# since most controllers using the get_transcript method
			# have already invoked an @expression resource

			resource = Lbp::Resource.find(resource_url)

      if resource.class == Lbp::Transcription
				return resource
			else
        begin
          return resource.canonical_transcription.resource
        rescue
          raise ActionController::RoutingError.new('Not Found')
        end
			end

		end
		def check_transcript_existence(expressionObj)
				unless expressionObj.canonical_transcription?
					expressionid = expressionObj.short_id
					redirect_to "/text/status/#{expressionid}", :alert => "A critical/normalized edition of this text does not exist yet. Below are the available transcriptions." and return
		end
  end
  def transcriptions_by_manifestation(results, manifestation)
    transcriptions = []
    results.each do |result|
      if result[:manifestation].to_s == manifestation
        transcription = {
          transcript: result[:transcript].to_s,
          transcript_title: result[:transcript_title].to_s,
          transcript_status: result[:transcript_status].to_s,
          transcript_type: result[:transcript_type].to_s,
          transcript_link: "/text/#{result[:transcript].to_s.split('/resource/').last}"
        }
        transcriptions << transcription
      end
    end
    return transcriptions
  end
  def order_manifestations(resource)
    #results = Lbp::Query.new.item_query(url)
    results = resource.manifestation_display
    results.order_by(:transcript_type)
    translation_results = resource.translation_display

    manifestations = results.map do |result|
      {
        manifestation: result[:manifestation].to_s,
        manifestation_title: result[:manifestation_title].to_s,
        transcriptions: transcriptions_by_manifestation(results, result[:manifestation].to_s)
      }
    end
    return manifestations.uniq
  end
end
