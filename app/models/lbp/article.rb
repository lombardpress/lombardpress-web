module Lbp
	class Article
    #method has put in MiscQuery beause I can't figure out how to get Rails to import this module extension

    # def version_history_info(transcription_rdf_id)
		# 	#url =  "<http://scta.info/resource/#{short_id}>"
		# 	#Lbp::Query.new().collection_query(url)
		# 	query = "
		# 		SELECT ?version ?order_number
	  #     {
    #       {
  	#         <#{transcription_rdf_id}> <http://scta.info/property/hasAncestor> ?version .
    #         ?version <http://scta.info/property/orderNumber> ?order_number .
    #       }
    #       UNION
    #       {
    #         <#{transcription_rdf_id}> <http://scta.info/property/hasDescendant> ?version .
    #         ?version <http://scta.info/property/orderNumber> ?order_number .
    #       }
    #     }
	  #     ORDER BY ?order_number"
		# 		results = Query.new.query(query)
		# end
  end
end
