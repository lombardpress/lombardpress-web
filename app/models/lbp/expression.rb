module Lbp
	class Expression
		def structure_items_display
			#url =  "<http://scta.info/resource/#{short_id}>"
			#Lbp::Query.new().collection_query(url)
			query = "
				SELECT ?collectiontitle ?title ?item ?questiontitle ?order ?status ?gitRepository
	      {
	        <http://scta.info/resource/#{short_id}> <http://scta.info/property/hasStructureItem> ?item .
	        <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?collectiontitle .
	        ?item <http://purl.org/dc/elements/1.1/title> ?title  .
	        ?item <http://scta.info/property/totalOrderNumber> ?order .
	        ?item <http://scta.info/property/status> ?status .
	        ?item <http://scta.info/property/gitRepository> ?gitRepository .
					OPTIONAL
	      	{
	      	?item <http://scta.info/property/questionTitle> ?questiontitle  .
	      	}
	      }
	      ORDER BY ?order"
				results = Query.new.query(query)
		end
		def info_display
			query = "SELECT ?description ?isPartOf ?hasPart ?sponsor ?sponsorTitle ?sponsorLogo ?sponsorLink ?article ?articleTitle
      {
         <http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/description> ?description .

         <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/isPartOf> ?isPartOf .
         OPTIONAL {
           <http://scta.info/resource/#{short_id}> <http://scta.info/property/hasSponsor> ?sponsor .
           ?sponsor <http://purl.org/dc/elements/1.1/title> ?sponsorTitle .
           ?sponsor <http://scta.info/property/link> ?sponsorLink .
           ?sponsor <http://scta.info/property/logo> ?sponsorLogo .
         }
         OPTIONAL {
          ?article <http://scta.info/property/isArticleOf> <http://scta.info/resource/#{short_id}> .
          ?article <http://purl.org/dc/elements/1.1/title> ?articleTitle .
         }
				 OPTIONAL {
          <http://scta.info/resource/#{short_id}> <http://purl.org/dc/terms/hasPart> ?hasPart .
         }
      }"
      results = Query.new.query(query)
		end
		def sponsors_display(info)
			sponsors = info.map {|r| {sponsor: r[:sponsor], sponsorTitle: r[:sponsorTitle], sponsorLogo: r[:sponsorLogo], sponsorLink: r[:sponsorLink]}}
			sponsors.uniq!
			# check to see if sponsors array is actaully empty. If it is, set it to empty array
			sponsors = sponsors[0][:sponsor] == nil ? [] : sponsors
		end
		def articles_display(info)
			articles = info.map {|r| {article: r[:article], articleTitle: r[:articleTitle]}}
			articles.uniq!
			# check to see if articles array is actaully empty. If it is, set it to empty array
			articles = articles[0][:article] == nil ? [] : articles
		end
		def manifestation_display
			query ="SELECT ?item_title ?transcript ?transcript_title ?transcript_status ?transcript_type ?manifestation ?manifestation_title ?language ?canonical_transcript
	    {
      	<http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?item_title .
      	?manifestation <http://scta.info/property/isManifestationOf> <http://scta.info/resource/#{short_id}> .
				?manifestation <http://scta.info/property/isManifestationOf> <http://scta.info/resource/#{short_id}> .
				OPTIONAL{
					?manifestation <http://purl.org/dc/elements/1.1/language> ?language .
				}
				?manifestation <http://purl.org/dc/elements/1.1/title> ?manifestation_title  .
				?manifestation <http://scta.info/property/hasTranscription> ?transcript .
				?transcript <http://scta.info/property/isTranscriptionOf> ?manifestation .
				OPTIONAL {
					?manifestation <http://scta.info/property/hasCanonicalTranscription> ?canonical_transcript .
				}
				?transcript <http://purl.org/dc/elements/1.1/title> ?transcript_title  .
        ?transcript <http://scta.info/property/status> ?transcript_status .
        ?transcript <http://scta.info/property/transcriptionType> ?transcript_type .
      }"
			results = Query.new.query(query)
		end
		def translation_display
			query ="SELECT ?item_title ?transcript ?transcript_title ?transcript_status ?language ?manifestation
	    {
      	<http://scta.info/resource/#{short_id}> <http://purl.org/dc/elements/1.1/title> ?item_title .
      	?manifestation <http://scta.info/property/isTranslationOf> <http://scta.info/resource/#{short_id}> .
				?manifestation <http://purl.org/dc/elements/1.1/language> ?language .
				?transcript <http://scta.info/property/isTranscriptionOf> ?manifestation .
				?transcript <http://purl.org/dc/elements/1.1/title> ?transcript_title  .
        #?transcript <http://scta.info/property/status> ?transcript_status .
        #?transcript <http://scta.info/property/transcriptionType> ?transcript_type .
      }"
			results = Query.new.query(query)
		end
	end
end
